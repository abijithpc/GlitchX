import 'package:flutter/material.dart';

Widget buildWalletCard(double balance) {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [Colors.deepPurple, Colors.indigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withAlpha(30),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.account_balance_wallet, color: Colors.white, size: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Current Balance',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${balance.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTransactionTile(dynamic tx) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Transaction History",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      SizedBox(height: 10),
      Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor:
                tx.type == 'credit' ? Colors.green[100] : Colors.red[100],
            child: Icon(
              tx.type == 'credit' ? Icons.arrow_downward : Icons.arrow_upward,
              color: tx.type == 'credit' ? Colors.green : Colors.red,
            ),
          ),
          title: Text(
            tx.description,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            formatDate(tx.timestamp),
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Text(
            '${tx.type == 'credit' ? '+' : '-'}₹${tx.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: tx.type == 'credit' ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    ],
  );
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year} • ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
