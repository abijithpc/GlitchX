import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Pages/cartpage.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Pages/wishlist_page.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_listpage.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Pages/edit_profile.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Pages/privacy_policy.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Pages/profile_detailspage.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Pages/terms_conditionpage.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/profile_avatar.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/profile_tile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ProfileDetailsSection extends StatelessWidget {
  final UserModel user;

  const ProfileDetailsSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileAvatar(user: user),
        const SizedBox(height: 16),
        Text(
          user.username,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        Text(
          user.mobile,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
        if (user.isGoogleUser == true)
          Container(
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(110),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                  height: 18,
                  width: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Signed in with Google",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
        ),
        ProfileTile(
          icon: Icons.favorite,
          title: "Favourites",
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder:
                    (context) => WishlistPage(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                    ),
              ),
            );
          },
        ),
        ProfileTile(
          icon: Icons.list_alt,
          title: "Orders",
          onTap: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (context) => OrdersPage()));
          },
        ),
        ProfileTile(
          icon: Icons.privacy_tip_outlined,
          title: "Privacy & Policy",
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
            );
          },
        ),
        ProfileTile(
          icon: Icons.description,
          title: "Terms & Conditions",
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => TermsConditionpage()),
            );
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
