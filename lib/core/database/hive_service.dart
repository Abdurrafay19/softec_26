import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../ledger/models/transaction.dart';

class HiveService {
  static const String _boxName = 'transactions_box';
  static const String _settingsBoxName = 'settings_box';
  static const String _biometricsKey = 'biometric_enabled';
  static const String _signupCompletedKey = 'signup_completed';
  static const String _userNameKey = 'user_name';

  // Initialize Hive and Register Adapter
  static Future<void> init() async {
    await Hive.initFlutter();
    //Hive.registerAdapter(TransactionAdapter());
    await Hive.openBox<Transaction>(_boxName);
    await Hive.openBox(_settingsBoxName);
  }

  // Get the box
  static Box<Transaction> getTransactionBox() => Hive.box<Transaction>(_boxName);

  static Box getSettingsBox() => Hive.box(_settingsBoxName);

  static ValueListenable<Box> settingsListenable() {
    return getSettingsBox().listenable();
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
}