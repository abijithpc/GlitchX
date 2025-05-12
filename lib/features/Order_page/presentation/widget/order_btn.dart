import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_summary_page.dart';

class order_btn extends StatelessWidget {
  const order_btn({
    super.key,
    required this.widget,
    required this.screenHeight,
    required this.screenWidth,
  });

  final OrderSummaryPage widget;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final user = FirebaseAuth.instance.currentUser;
        print('${user?.phoneNumber}');
        print('${user?.email}');
    
        if (user == null || user.email == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "User data incomplete. Cannot proceed with payment.",
              ),
            ),
          );
          return;
        }
    
        final paymentRequest = PaymentModel(
          amount: widget.grandTotal,
          name: "GlitchX",
          description: 'Order payment',
          // contact: user.phoneNumber ?? '',
          email: user.email!,
        );
    
        context.read<PaymentBloc>().add(
          StartPaymentEvent(paymentRequest),
        );
      },
    
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.018,
          horizontal: screenHeight * 0.030,
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
        'Order Now',
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
