import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_summary_page.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/selectaddress_page.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.widget,
    this.selectedAddress, // Add selectedAddress as a parameter
    required this.onAddressSelected,
  });

  final double screenWidth;
  final double screenHeight;
  final OrderSummaryPage widget;
  final AddressModel? selectedAddress; // Address? type
  final Function(AddressModel)
  onAddressSelected; // Callback function to update the selected address

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Delivery Info
        Container(
          width: screenWidth,
          height: screenHeight * 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Deliver To :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final address = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressPage()),
                      );
                      if (address != null) {
                        // Update the selected address when a new one is selected
                        onAddressSelected(
                          address,
                        ); // Update the parent widget with the new address
                      }
                    },
                    child: const Text("Change"),
                  ),
                ],
              ),
              // Address info placeholder
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    selectedAddress != null
                        ? "${selectedAddress?.name}, ${selectedAddress?.house}, ${selectedAddress?.area}, ${selectedAddress?.city}"
                        : "Your saved address goes here...",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Cart Items List
        ...widget.cartItems.map((items) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      items.imageUrl.isNotEmpty
                          ? Image.network(
                            items.imageUrl,
                            width: screenWidth * 0.28,
                            height: screenHeight * 0.15,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => const Icon(
                                  Icons.broken_image,
                                  color: Colors.white54,
                                ),
                          )
                          : const Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Colors.white54,
                          ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Price: ₹${items.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Qty: ${items.quantity}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Category: ${items.category ?? 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      if (items.price > 1000) ...[
                        const SizedBox(height: 6),
                        const Text(
                          "Delivery: Free",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 80), // Padding for fixed footer
      ],
    );
  }
}
