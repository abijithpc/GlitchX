import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_event.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_state.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_details_page.dart';
import 'package:intl/intl.dart'; // Add this for formatting date

// ignore: camel_case_types
class OrderList_widget extends StatelessWidget {
  const OrderList_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withAlpha(85),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.swipe, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Swipe to Cancel the Orders",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    final firstItem =
                        order.items.isNotEmpty ? order.items[0] : null;

                    String deliveredDateText = '';
                    if (order.orderAt != null) {
                      deliveredDateText =
                          'Ordered: ${DateFormat.yMMMd().format(order.orderAt)}';
                    }

                    return Dismissible(
                      key: ValueKey(order.id),
                      direction:
                          order.status.toLowerCase() == 'delivered' ||
                                  order.status.toLowerCase() == 'cancelled'
                              ? DismissDirection.none
                              : DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.redAccent,
                        child: const Icon(Icons.cancel, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        if (order.status.toLowerCase() != 'ordered') {
                          // Don't allow dismiss for delivered/cancelled orders
                          return false;
                        }

                        bool? confirm = await showDialog<bool>(
                          context: context,
                          builder:
                              (ctx) => CupertinoAlertDialog(
                                title: const Text('Cancel Order'),
                                content: const Text(
                                  'Are you sure you want to cancel this order?',
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed:
                                        () => Navigator.of(ctx).pop(false),
                                    child: const Text('No'),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed:
                                        () => Navigator.of(ctx).pop(true),
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                        );

                        if (confirm == true) {
                          context.read<OrderBloc>().add(
                            CancelOrderEvent(order.id),
                          );
                        }
                        return confirm ?? false;
                      },

                      child: Card(
                        color: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading:
                              firstItem != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      firstItem.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white54,
                                    size: 60,
                                  ),
                          title: Text(
                            firstItem?.name ?? 'Unknown Item',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  firstItem != null
                                      ? 'Quantity: ${firstItem.quantity ?? 0}\nPrice: ₹ ${firstItem.price ?? 0}'
                                      : 'No item details available',
                                  style: const TextStyle(color: Colors.white70),
                                ),

                                if (deliveredDateText.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      deliveredDateText,
                                      style: const TextStyle(
                                        color: Colors.greenAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderDetailsPage(order: order),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
    );
  }
}
