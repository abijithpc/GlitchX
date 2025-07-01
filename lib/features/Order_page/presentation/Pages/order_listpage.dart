import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/orderlist_widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  
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
        actions: [
          IconButton(
            onPressed: () => context.read<OrderBloc>().add(FetchOrders(userId)),
            icon: Icon(Icons.replay),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ScreenBackGround(
        screenHeight: screen.size.height,
        screenWidth: screen.size.width,
        alignment: Alignment.topCenter,
        widget: OrderList_widget(),
      ),
    );
  }
}
