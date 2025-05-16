import 'package:flutter/material.dart';

class OrderFailedPage extends StatelessWidget {
  final String error;

  const OrderFailedPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Failed")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Order failed due to:\n$error",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
