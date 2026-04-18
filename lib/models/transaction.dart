import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String name;
  final DateTime date;
  final double amount;
  final IconData icon;
  final bool isPending;

  const Transaction({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.icon,
    this.isPending = false,
  });
}