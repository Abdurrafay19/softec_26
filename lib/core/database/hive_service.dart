import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import '../../ledger/models/transaction.dart';
import '../../goals/models/goal.dart';

class HiveService {
  static const String _boxName = 'transactions_box';
  static const String _goalsBoxName = 'goals_box';
  static const String _settingsBoxName = 'settings_box';
  static const String _biometricsKey = 'biometric_enabled';
  static const String _signupCompletedKey = 'signup_completed';
  static const String _userNameKey = 'user_name';

  // Initialize Hive and Register Adapter
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Check if adapter is registered to avoid duplicate registration errors
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TransactionAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GoalAdapter());
    }
    
    await Hive.openBox<Transaction>(_boxName);
    await Hive.openBox<Goal>(_goalsBoxName);
    await Hive.openBox(_settingsBoxName);
  }

  // Get the boxes
  static Box<Transaction> getTransactionBox() => Hive.box<Transaction>(_boxName);
  static Box<Goal> getGoalsBox() => Hive.box<Goal>(_goalsBoxName);
  static Box getSettingsBox() => Hive.box(_settingsBoxName);

  static ValueListenable<Box> settingsListenable() {
    return getSettingsBox().listenable();
  }

  static ValueListenable<Box<Goal>> goalsListenable() {
    return getGoalsBox().listenable();
  }

  static bool isBiometricsEnabled() {
    final box = getSettingsBox();
    return box.get(_biometricsKey, defaultValue: false) as bool;
  }

  static Future<void> setBiometricsEnabled(bool value) async {
    final box = getSettingsBox();
    await box.put(_biometricsKey, value);
  }

  static bool isSignupCompleted() {
    final box = getSettingsBox();
    return box.get(_signupCompletedKey, defaultValue: false) as bool;
  }

  static Future<void> setSignupCompleted(bool value) async {
    final box = getSettingsBox();
    await box.put(_signupCompletedKey, value);
  }

  static String getUserName() {
    final box = getSettingsBox();
    return box.get(_userNameKey, defaultValue: '') as String;
  }

  static Future<void> setUserName(String value) async {
    final box = getSettingsBox();
    await box.put(_userNameKey, value);
  }

  // Add Transaction
  static Future<void> addTransaction(Transaction transaction) async {
    final box = getTransactionBox();
    await box.add(transaction);
  }

  // Get All Transactions (Ordered by date)
  static List<Transaction> getAllTransactions() {
    final box = getTransactionBox();
    final list = box.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  // Goals CRUD
  static Future<void> addGoal(Goal goal) async {
    final box = getGoalsBox();
    await box.put(goal.id, goal);
  }

  static Future<void> updateGoal(Goal goal) async {
    final box = getGoalsBox();
    await box.put(goal.id, goal);
  }

  static Future<void> deleteGoal(String id) async {
    final box = getGoalsBox();
    await box.delete(id);
  }

  static List<Goal> getAllGoals() {
    return getGoalsBox().values.toList();
  }

  static Future<void> deleteAccountData() async {
    await getSettingsBox().clear();
    await getTransactionBox().clear();
    await getGoalsBox().clear();
  }

  // --- Backup & Export Logic ---

  static Future<void> exportBackup() async {
    try {
      final transactions = getTransactionBox().values.map((t) => {
        'id': t.id,
        'amount': t.amount,
        'isMoneyIn': t.isMoneyIn,
        'name': t.name,
        'description': t.description,
        'date': t.date.toIso8601String(),
        'category': t.category,
      }).toList();

      final goals = getGoalsBox().values.map((g) => {
        'id': g.id,
        'name': g.name,
        'targetAmount': g.targetAmount,
        'dueDate': g.dueDate?.toIso8601String(),
        'currentAmount': g.currentAmount,
      }).toList();

      final backupData = {
        'version': 1,
        'exportedAt': DateTime.now().toIso8601String(),
        'transactions': transactions,
        'goals': goals,
      };

      final jsonString = jsonEncode(backupData);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/pocketra_backup.json');
      await file.writeAsString(jsonString);

      await Share.shareXFiles([XFile(file.path)], text: 'Pocketra Backup');
    } catch (e) {
      debugPrint('Export failed: $e');
      rethrow;
    }
  }

  static Future<bool> importBackup() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();
        final data = jsonDecode(content) as Map<String, dynamic>;

        if (!data.containsKey('transactions') || !data.containsKey('goals')) {
          throw Exception('Invalid backup file format');
        }

        final txBox = getTransactionBox();
        final goalsBox = getGoalsBox();

        await txBox.clear();
        await goalsBox.clear();

        final transactions = data['transactions'] as List;
        for (var t in transactions) {
          await txBox.add(Transaction(
            id: t['id'],
            amount: t['amount'].toDouble(),
            isMoneyIn: t['isMoneyIn'],
            name: t['name'],
            description: t['description'],
            date: DateTime.parse(t['date']),
            category: t['category'],
          ));
        }

        final goals = data['goals'] as List;
        for (var g in goals) {
          await goalsBox.put(g['id'], Goal(
            id: g['id'],
            name: g['name'],
            targetAmount: g['targetAmount'].toDouble(),
            dueDate: g['dueDate'] != null ? DateTime.parse(g['dueDate']) : null,
            currentAmount: g['currentAmount'].toDouble(),
          ));
        }

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Import failed: $e');
      rethrow;
    }
  }
}
