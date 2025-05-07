class CartModel {
  final String userId;
  final String productId;
  final String name;
  final String imageUrl;
  final int price;
  final int quantity;

  CartModel({
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['userId'] ?? '',
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      imageUrl: json['imageUrl'] ?? '', // Ensure this is being set correctly
    );
  }
}
