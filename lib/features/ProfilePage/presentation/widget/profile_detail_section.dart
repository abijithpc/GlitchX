import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/edit_profile.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/profile_detailspage.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/widget/profile_tile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ProfileDetailsSection extends StatelessWidget {
  final UserModel user;

  const ProfileDetailsSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileAvatar(user),
        const SizedBox(height: 16),
        Text(
          user.username ?? "No Name",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email ?? "No Email",
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        Text(
          user.mobile ?? "No Mobile Number",
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
        const SizedBox(height: 20),
        const Divider(thickness: 2, color: Colors.white30),
        const SizedBox(height: 10),
        ProfileTile(
          icon: Icons.person,
          title: "User Profile",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileDetailspage()),
            );
          },
        ),

        ProfileTile(
          icon: Icons.edit,
          title: "Edit Profile",
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const EditProfilePage(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
        ),
        ProfileTile(
          icon: Icons.shopping_cart,
          title: "Cart Page",
          onTap: () {},
        ),
        ProfileTile(icon: Icons.favorite, title: "Favourites", onTap: () {}),
        ProfileTile(icon: Icons.list_alt, title: "Orders", onTap: () {}),
        ProfileTile(
          icon: Icons.privacy_tip_outlined,
          title: "Privacy & Policy",
          onTap: () {},
        ),
        ProfileTile(
          icon: Icons.description,
          title: "Terms & Conditions",
          onTap: () {},
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProfileAvatar(UserModel user) {
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
