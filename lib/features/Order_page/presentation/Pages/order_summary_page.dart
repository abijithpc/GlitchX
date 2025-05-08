// In OrderSummaryPage
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/order_summary_card.dart';

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
            // Fixed Order Summary Footer
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
                  _buildSummaryRow(
                    "Items (${widget.totalItems})",
                    "₹${_calculateSubtotal(widget.cartItems)}",
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow("Shipping Fee", "₹ ${widget.shippingFee}"),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    "Grand Total",
                    "₹${widget.grandTotal.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.018,
                        horizontal: screenHeight * 0.028,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 6,
                    ),
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: isBold ? Colors.white : Colors.white60,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
