import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_summary_page.dart';

class CartPageCard extends StatelessWidget {
  final List<CartModel> cartItems;
  final double screenWidth;
  final int totalItems;
  final double shippingFee;
  final double grandTotal;
  final double screenHeight;

  const CartPageCard({
    super.key,
    required this.cartItems,
    required this.screenWidth,
    required this.totalItems,
    required this.shippingFee,
    required this.grandTotal,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: cartItems.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.white12),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return _buildCartItem(context, item);
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildSummaryCard(context),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartModel item) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.015), // smaller padding
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12), // slightly smaller radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                item.imageUrl.isNotEmpty
                    ? Image.network(
                      item.imageUrl,
                      width: screenWidth * 0.18, // smaller image
                      height: screenWidth * 0.18,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: screenWidth * 0.18,
                          ),
                    )
                    : Icon(
                      Icons.broken_image,
                      color: Colors.white54,
                      size: screenWidth * 0.18,
                    ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item.price}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth * 0.034,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      'Qty: ${item.quantity}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () => _showDeleteDialog(context, item),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.045),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow("Total Items", '$totalItems'),
          const SizedBox(height: 10),
          _buildSummaryRow(
            "Shipping Fee",
            shippingFee == 0 ? "Free" : '₹$shippingFee',
            valueColor: shippingFee == 0 ? Colors.green : Colors.orangeAccent,
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            "Grand Total",
            '₹$grandTotal',
            isBold: true,
            valueColor: Colors.greenAccent,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) return;
                final order = OrderModel(
                  id: UniqueKey().toString(),
                  userId: user.uid,
                  items:
                      cartItems.map((item) {
                        return OrderItem(
                          productId: item.productId,
                          name: item.name,
                          price: item.price,
                          quantity: item.quantity,
                          imageUrl: item.imageUrl,
                        );
                      }).toList(),
                  totalAmount: cartItems.fold(
                    0,
                    (sum, item) => sum + item.price * item.quantity,
                  ),
                  status: 'Pending',
                  orderAt: DateTime.now(),
                  address: {}, // fill this later on OrderSummaryPage
                );

                Navigator.of(context, rootNavigator: true)
                    .push(
                      MaterialPageRoute(
                        builder:
                            (_) => OrderSummaryPage(
                              cartItems: cartItems,
                              grandTotal: grandTotal,
                              shippingFee: shippingFee,
                              totalItems: totalItems,
                              order: [order],
                              isFromCart: true,
                            ),
                      ),
                    )
                    .then((PaymentSuccess) {
                      if (PaymentSuccess == true) {
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          // Clear or reload cart items after order placed
                          context.read<CartBloc>().add(
                            FetchCartItemsEvent(userId),
                          );
                        }
                      }
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(
                Icons.shopping_cart_checkout,
                color: Colors.white,
              ),
              label: Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            color: Colors.white70,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            color: valueColor ?? Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, CartModel item) {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: const Text("Delete Cart Item"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog

                final userId = FirebaseAuth.instance.currentUser?.uid;

                if (userId != null) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    context.read<CartBloc>().add(
                      RemoveCartItemEvent(item.productId, userId),
                    );
                  });
                }
              },
              child: const Text("Delete"),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
