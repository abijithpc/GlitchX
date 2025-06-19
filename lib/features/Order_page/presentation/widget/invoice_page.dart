import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Widget/bottomnavigation_bar.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';

class InvoicePage extends StatefulWidget {
  final List<OrderModel> order;
  final bool isFromCart;

  const InvoicePage({super.key, required this.order, required this.isFromCart});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = widget.order;

    final totalPrice = orders.fold<double>(
      0,
      (sum, order) =>
          sum +
          order.items.fold<double>(
            0,
            (itemSum, item) => itemSum + (item.price * item.quantity),
          ),
    );

    final totalQuantity = orders.fold<int>(
      0,
      (sum, order) =>
          sum +
          order.items.fold<int>(0, (itemSum, item) => itemSum + item.quantity),
    );

    // Combine all product names separated by commas
    final productNames = orders
        .expand((order) => order.items) // flatten all items from all orders
        .map((item) => item.name) // map each item to its name
        .join(", "); // join names with commas

    // You can decide how to handle status — here I just take the status of the first order
    final status = orders.isNotEmpty ? orders.first.status : "N/A";

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe0f7fa), Color(0xFFffffff)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Confetti animation
          Confetti(confettiController: _confettiController),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 90,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your Order was Successful!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Thank you for shopping with us.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // Single summary invoice card
                  Expanded(
                    child: Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "🆔 Order IDs: ${orders.map((o) => o.id).join(", ")}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "🎮 Products: $productNames",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "🔢 Total Quantity: $totalQuantity",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "💰 Grand Total: ₹$totalPrice",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "📦 Status: $status",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Go to Home Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(Icons.home),
                    label: const Text(
                      "Go to Home",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersistentBottomNavigationBar(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Confetti extends StatelessWidget {
  const Confetti({super.key, required ConfettiController confettiController})
    : _confettiController = confettiController;

  final ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: pi / 2,
        emissionFrequency: 0.07,
        numberOfParticles: 25,
        maxBlastForce: 30,
        minBlastForce: 10,
        gravity: 0.3,
        colors: const [Colors.green, Colors.blue, Colors.purple, Colors.orange],
      ),
    );
  }
}
