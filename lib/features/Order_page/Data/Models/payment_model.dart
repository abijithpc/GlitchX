class PaymentModel {
  final double amount;
  final String name;
  final String description;
  // final String? contact;
  final String email;

  PaymentModel({
    required this.amount,
    required this.name,
    required this.description,
    // required this.contact,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'name': name,
      'description': description,
      // // 'contact': contact,
      'email': email,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      amount: map['amount']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      // // contact: map['contact'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
