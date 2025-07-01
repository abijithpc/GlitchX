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
    final isWeb = screenWidth > 800;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: cartItems.length,
            separatorBuilder:
                (_, __) =>
                    Divider(color: Colors.white12, height: screenHeight * 0.01),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return _buildCartItem(context, item, isWeb);
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        _buildSummaryCard(context, isWeb),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartModel item, bool isWeb) {
    final imageSize = isWeb ? 80.0 : screenWidth * 0.18;
    final fontSize = screenWidth * 0.01;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                item.imageUrl.isNotEmpty
                    ? Image.network(
                      item.imageUrl,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: imageSize,
                          ),
                    )
                    : Icon(
                      Icons.broken_image,
                      color: Colors.white54,
                      size: imageSize,
                    ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '₹${item.price}',
                  style: TextStyle(
                    fontSize: fontSize * 0.9,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  item.category,
                  style: TextStyle(
                    fontSize: fontSize * 0.85,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Qty: ${item.quantity}',
                        style: TextStyle(
                          fontSize: fontSize * 0.85,
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01), // add spacing
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      iconSize: fontSize * 1.1, // slightly smaller
                      onPressed: () => _showDeleteDialog(context, item),
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: fontSize * 1.1,
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

  Widget _buildSummaryCard(BuildContext context, bool isWeb) {
    final fontScale = screenWidth < 400 ? 0.6 : 0.19;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8)],
          ),
          child: Column(
            children: [
              _buildSummaryRow(
                "Total Items",
                '$totalItems',
                fontScale: fontScale,
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildSummaryRow(
                "Shipping Fee",
                shippingFee == 0 ? "Free" : '₹$shippingFee',
                valueColor:
                    shippingFee == 0 ? Colors.green : Colors.orangeAccent,
                fontScale: fontScale,
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildSummaryRow(
                "Grand Total",
                '₹$grandTotal',
                isBold: true,
                valueColor: Colors.greenAccent,
                fontScale: fontScale + 0.1,
              ),
              SizedBox(height: screenHeight * 0.02),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: screenWidth * 0.010,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => _onCheckoutPressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.018,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
    double fontScale = 1,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.042 * fontScale,
            color: Colors.white70,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.042 * fontScale,
            color: valueColor ?? Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _onCheckoutPressed(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final order = OrderModel(
      id: UniqueKey().toString(),
      userId: user.uid,
      items:
          cartItems
              .map(
                (item) => OrderItem(
                  productId: item.productId,
                  name: item.name,
                  price: item.price,
                  quantity: item.quantity,
                  imageUrl: item.imageUrl,
                ),
              )
              .toList(),
      totalAmount: cartItems.fold(
        0,
        (sum, item) => sum + item.price * item.quantity,
      ),
      status: 'Pending',
      orderAt: DateTime.now(),
      address: {},
    );

    Navigator.of(context)
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
        .then((paymentSuccess) {
          if (paymentSuccess == true) {
            final userId = FirebaseAuth.instance.currentUser?.uid;
            if (userId != null) {
              context.read<CartBloc>().add(FetchCartItemsEvent(userId));
            }
          }
        });
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
                Navigator.of(dialogContext).pop();
                final userId = FirebaseAuth.instance.currentUser?.uid;
                if (userId != null) {
                  context.read<CartBloc>().add(
                    RemoveCartItemEvent(item.productId, userId),
                  );
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
