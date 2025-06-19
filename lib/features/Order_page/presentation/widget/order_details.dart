import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:intl/intl.dart';

String formatAddress(Map<String, dynamic> address) {
  final name = address['name'] ?? '';
  final phone = address['phone'] ?? '';
  final street = address['street'] ?? '';
  final city = address['city'] ?? '';
  final state = address['state'] ?? '';
  final pincode = address['pincode'] ?? '';
  return '$name\n$phone\n$street\n$city, $state - $pincode';
}

ListView Order_details(
  OrderModel order,
  int totalQuantity,
  String Function(Map<String, dynamic> address),
) {
  return ListView(
    children: [
      const SizedBox(height: 20),

      // Show first item's image as order image
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            order.items[0].imageUrl,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 60,
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey[800],
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white70,
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        order.items[0].name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        'Order Id: ${order.id}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      _buildDetailRow('Price', '₹ ${order.totalAmount.toStringAsFixed(2)}'),
      _buildDetailRow('Quantity', totalQuantity.toString()),
      _buildDetailRow(
        'Status',
        order.status,
        valueColor:
            order.status.toLowerCase() == 'delivered'
                ? Colors.greenAccent
                : Colors.orangeAccent,
      ),
      _buildDetailRow('Order Date', DateFormat.yMMMMd().format(order.orderAt)),
      const SizedBox(height: 13),
      Divider(),
      const Text(
        'Shipping Address',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        order.address != null
            ? formatAddress(order.address)
            : 'No address available',
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),

      const SizedBox(height: 20),
      const Divider(thickness: 2, color: Colors.white54),
      const SizedBox(height: 10),
      const Text(
        'Ordered Items',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      ...order.items.map(
        (item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Qty: ${item.quantity}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Text(
                '₹ ${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildDetailRow(
  String label,
  String value, {
  Color valueColor = Colors.white70,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 18),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
