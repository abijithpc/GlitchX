class Usermodels {
  final String id;
  final String email;
  final String username;
  final String mobileNumber;

  Usermodels({
    required this.id,
    required this.email,
    required this.username,
    required this.mobileNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'mobileNumber': mobileNumber,
    };
  }

  factory Usermodels.fromJson(Map<String, dynamic> json) {
    return Usermodels(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      mobileNumber: json['mobileNumber'],
    );
  }
}
