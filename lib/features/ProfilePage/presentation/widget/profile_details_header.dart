import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 126, 106, 106),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                imageUrl != null
                    ? NetworkImage(imageUrl!)
                    : const AssetImage('Assets/Auth_Icon/icon-5359554_1280.png')
                        as ImageProvider,
          ),
          const SizedBox(height: 12),
          Text(
            username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            email,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
