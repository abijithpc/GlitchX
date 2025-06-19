import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';

class ProfileAvatar extends StatelessWidget {
  final UserModel user;

  const ProfileAvatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final hasImage =
        user.profilePictureUrl != null && user.profilePictureUrl!.isNotEmpty;

    return ClipOval(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white30, width: 2),
        ),
        child:
            hasImage
                ? Image.network(
                  user.profilePictureUrl!,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                )
                : const Icon(Icons.person, size: 60, color: Colors.white),
      ),
    );
  }
}
