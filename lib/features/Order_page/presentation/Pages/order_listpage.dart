import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_state.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final screen = MediaQuery.of(context);

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: const Center(
          child: Text(
            'User not logged in',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      );
    }

    context.read<OrderBloc>().add(FetchOrders(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ScreenBackGround(
        screenHeight: screen.size.height,
        screenWidth: screen.size.width,
        alignment: Alignment.topCenter,
        widget: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is OrderPlaced) {
              if (state.orders.isEmpty) {
                return const Center(
                  child: Text(
                    'No orders placed yet.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          order.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        order.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Quantity: ${order.quantity}\nPrice:₹ ${order.price}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      trailing: Text(
                        order.status,
                        style: TextStyle(
                          color:
                              order.status.toLowerCase() == 'delivered'
                                  ? Colors.greenAccent
                                  : Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: true,
                      onTap: () {},
                    ),
                  );
                },
              );
            } else if (state is OrderError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
