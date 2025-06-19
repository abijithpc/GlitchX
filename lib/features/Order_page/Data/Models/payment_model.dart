import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';

class PaymentModel {
  final double amount;
  final String name;
  final String description;
  final String email;
  final List<CartModel> orderItems;

  PaymentModel({
    required this.amount,
    required this.name,
    required this.description,
    required this.email,
    required this.orderItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'name': name,
      'description': description,
      'email': email,
      'orderItems': orderItems.map((e) => e.toJson()).toList(),
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      amount: map['amount']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      email: map['email'] ?? '',
      orderItems:
          (map['orderItems'] as List<dynamic>?)
              ?.map((item) => CartModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
