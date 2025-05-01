class UserModel {
  final String id;
  final String username;
  final String email;
  final String mobile;
  final String? profilePictureUrl;
  final bool? isGoogleUser;
  final String? location;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.location,
    this.profilePictureUrl,
    this.isGoogleUser = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      profilePictureUrl: map['profilePictureUrl'],
      isGoogleUser: map['isGoogleUser'] ?? false,
      location: map['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'mobile': mobile,
      'profilePictureUrl': profilePictureUrl,
      'isGoogleUser': isGoogleUser,
      'location': location,
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? mobile,
    String? profilePictureUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isGoogleUser: isGoogleUser ?? this.isGoogleUser,
      location: location ?? this.location,
    );
  }
}
