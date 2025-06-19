import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_state.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/widget/cartpage_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    // Fetch cart items after widget builds using logged-in user ID
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        context.read<CartBloc>().add(FetchCartItemsEvent(userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenWidth = screen.width;
    final screenHeight = screen.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return buildShimmerLoading();
          } else if (state is CartLoaded) {
            final cartItems = state.cartItems;

            if (cartItems.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              );
            }

            final double subtotal = cartItems.fold(
              0,
              (sum, item) => sum + (item.price * item.quantity),
            );

            final int totalItems = cartItems.fold(
              0,
              (sum, item) => sum + item.quantity,
            );

            final double shippingFee = subtotal < 1000 ? 99.0 : 0.0;

            final double grandTotal = subtotal + shippingFee;

            return ScreenBackGround(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              alignment: Alignment.center,
              widget: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: CartPageCard(
                  cartItems: cartItems,
                  screenWidth: screenWidth,
                  totalItems: totalItems,
                  shippingFee: shippingFee,
                  grandTotal: grandTotal,
                  screenHeight: screenHeight,
                ),
              ),
            );
          } else if (state is CartError) {
            return Center(
              child: Text(
                'Error loading cart: ${state.message}',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
