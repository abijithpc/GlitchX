import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
// import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_bloc.dart';
// import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_state.dart';
// import 'package:glitchxscndprjt/features/Order_page/presentation/Payment_failure_success.dart/order_failurepage.dart';
// import 'package:glitchxscndprjt/features/Order_page/presentation/Payment_failure_success.dart/payment_reciptpage.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/order_btn.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/order_summary_card.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/summary_row.dart';

class OrderSummaryPage extends StatefulWidget {
  final List<CartModel> cartItems;
  final int totalItems;
  final double shippingFee;
  final double grandTotal;
  final AddressModel? selectedAddress; // Add a selectedAddress parameter

  const OrderSummaryPage({
    super.key,
    required this.cartItems,
    required this.totalItems,
    required this.shippingFee,
    required this.grandTotal,
    this.selectedAddress, // Accept selectedAddress
  });

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  int _calculateSubtotal(List<CartModel> items) {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  AddressModel? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final screenHeight = screen.size.height;
    final screenWidth = screen.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ScreenBackGround(
        widget: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: OrderSummaryCard(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  widget: widget,
                  selectedAddress: selectedAddress,
                  onAddressSelected: (address) {
                    setState(() {
                      selectedAddress = address;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[900],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSummaryRow(
                    "Items (${widget.totalItems})",
                    "₹${_calculateSubtotal(widget.cartItems)}",
                  ),
                  const SizedBox(height: 8),
                  buildSummaryRow(
                    "Shipping Fee",
                    "₹ ${widget.shippingFee == 0 ? 'Free' : widget.shippingFee}",
                  ),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 8),
                  buildSummaryRow(
                    "Grand Total",
                    "₹${widget.grandTotal.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                  const SizedBox(height: 10),
                  order_btn(
                    widget: widget,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
