import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String mobile;
  final String? profilePictureUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    this.profilePictureUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      profilePictureUrl: map['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'mobile': mobile,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
