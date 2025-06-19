import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_state.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_state.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_summary_page.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/invoice_page.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/order_fail_invoice.dart';
import 'package:uuid/uuid.dart';

class OrderBtn extends StatefulWidget {
  final OrderSummaryPage widget;
  final double screenHeight;
  final double screenWidth;
  final double grandTotal;
  final bool isFromCart;
  final AddressModel address;

  const OrderBtn({
    super.key,
    required this.widget,
    required this.screenHeight,
    required this.screenWidth,
    required this.grandTotal,
    required this.isFromCart,
    required this.address,
  });

  @override
  State<OrderBtn> createState() => _OrderBtnState();
}

class _OrderBtnState extends State<OrderBtn> {
  bool _orderPlacedForCurrentPayment = false;
  bool _isPaymentInProgress = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, paymentState) {
            debugPrint('PaymentState: $paymentState');
            if (paymentState is PaymentSuccess) {
              if (_orderPlacedForCurrentPayment) return;
              print("Address is : ${widget.address.toString()}");

              final user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User not logged in")),
                );
                return;
              }

              _orderPlacedForCurrentPayment = true;

              final uuid = Uuid();
              final orderItems =
                  widget.widget.cartItems.map((cartItem) {
                    return OrderItem(
                      productId: cartItem.productId,
                      name: cartItem.name,
                      price: cartItem.price,
                      quantity: cartItem.quantity,
                      imageUrl: cartItem.imageUrl,
                    );
                  }).toList();

              final order = OrderModel(
                id: uuid.v4(),
                userId: FirebaseAuth.instance.currentUser!.uid,
                items: orderItems,
                totalAmount: widget.grandTotal.toInt(),
                status: 'Pending',
                orderAt: DateTime.now(),
                address: widget.address.toMap(),
              );

              context.read<OrderBloc>().add(PlaceOrderEvent([order], user.uid));
            } else if (paymentState is PaymentFailure) {
              _orderPlacedForCurrentPayment = false;
              _isPaymentInProgress = false;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Payment failed: ${paymentState.error}"),
                ),
              );
            } else if (paymentState is PaymentInProgress) {
              _isPaymentInProgress = true;
            }
          },
        ),
        BlocListener<OrderBloc, OrderState>(
          listener: (context, orderState) {
            debugPrint('OrderState: $orderState');
            if (orderState is OrderPlaced) {
              _orderPlacedForCurrentPayment = false;
              _isPaymentInProgress = false;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order placed successfully!")),
              );
              debugPrint('isFromCart: ${widget.isFromCart}');

              if (widget.isFromCart == true) {
                final userId = FirebaseAuth.instance.currentUser?.uid;
                debugPrint("🟡 Dispatching ClearCartEvent for userId: $userId");

                if (userId != null) {
                  context.read<CartBloc>().add(ClearCartEvent(userId));
                }
              }
              debugPrint(
                "🔴 Skipping ClearCartEvent because isFromCart == false",
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => InvoicePage(
                        order: orderState.orders,
                        isFromCart: widget.isFromCart,
                      ),
                ),
              );
            } else if (orderState is OrderError) {
              _orderPlacedForCurrentPayment = false;
              _isPaymentInProgress = false;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Order failed: ${orderState.message}")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderFailedPage(error: orderState.message),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, orderState) {
          final isLoading = orderState is OrderLoading || _isPaymentInProgress;

          return ElevatedButton.icon(
            onPressed:
                isLoading
                    ? null
                    : () {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null || user.email == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "User data incomplete. Cannot proceed with payment.",
                            ),
                          ),
                        );
                        return;
                      }

                      // Trigger payment
                      final paymentRequest = PaymentModel(
                        amount: widget.widget.grandTotal,
                        name: "GlitchX",
                        description: 'Order payment',
                        email: user.email!,
                        orderItems: widget.widget.cartItems,
                      );

                      context.read<PaymentBloc>().add(
                        StartPaymentEvent(paymentRequest),
                      );
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(
                vertical: widget.screenHeight * 0.018,
                horizontal: widget.screenHeight * 0.030,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 6,
            ),
            icon:
                isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    ),
            label: Text(
              isLoading ? 'Processing...' : 'Order Now',
              style: TextStyle(
                fontSize: widget.screenWidth * 0.045,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}
