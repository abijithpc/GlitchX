class OrderModel {
  final String id;
  final String userId;
  final String productId;
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;
  final String status;
  final DateTime orderAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.status,
    required this.orderAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'status': status,
      'orderedAt': orderAt.toIso8601String(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['userId'],
      productId: map['productId'],
      name: map['name'],
      price:
          map['price'] is int
              ? map['price']
              : int.tryParse(map['price'].toString()) ?? 0,
      quantity:
          map['quantity'] is int
              ? map['quantity']
              : int.tryParse(map['quantity'].toString()) ?? 1,
      imageUrl: map['imageUrl'],
      status: map['status'],
      orderAt: DateTime.parse(map['orderedAt']),
    );
  }
}
