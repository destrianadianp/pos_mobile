import 'package:flutter/material.dart';

class Transaction {
  final String date;
  final String address;
  final double totalPrice;

  Transaction({
    required this.date,
    required this.address,
    required this.totalPrice,
  });
}

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
