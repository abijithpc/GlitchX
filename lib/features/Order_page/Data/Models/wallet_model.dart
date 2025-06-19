import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  final String userId;
  final double balance;

  WalletModel({required this.userId, required this.balance});

  factory WalletModel.fromMap(Map<String, dynamic> map, String userId) {
    return WalletModel(
      userId: userId,
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'balance': balance, 'lastUpdated': FieldValue.serverTimestamp()};
  }
}

class WalletTransaction {
  final String id;
  final double amount;
  final String type; // e.g. 'credit', 'debit'
  final String description;
  final DateTime timestamp;

  WalletTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
  });

  factory WalletTransaction.fromMap(Map<String, dynamic> map, String id) {
    return WalletTransaction(
      id: id,
      amount: (map['amount'] as num).toDouble(),
      type: map['type'] as String,
      description: map['description'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'type': type,
      'description': description,
      'timestamp': timestamp,
    };
  }
}
