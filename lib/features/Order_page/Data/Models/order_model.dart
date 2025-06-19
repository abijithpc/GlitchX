import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final int totalAmount;
  final String status;
  final DateTime orderAt;
  final Map<String, dynamic> address;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderAt,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'orderedAt': Timestamp.fromDate(orderAt),
      'address': address,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['userId'],
      items:
          (map['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromMap(item))
              .toList() ??
          [],
      totalAmount: map['totalAmount'] ?? 0,
      status: map['status'],
      orderAt:
          map['orderedAt'] is Timestamp
              ? (map['orderedAt'] as Timestamp).toDate()
              : DateTime.now(),

      address:
          map['address'] is Map
              ? Map<String, dynamic>.from(map['address'])
              : <String, dynamic>{}, // use an empty map as fallback
    );
  }
}

class OrderItem {
  final String productId;
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
    );
  }
}
