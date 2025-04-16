import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/screenbackground.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/edit_profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add((LoadUserProfile()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black87,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.user;

            return ScreenBackGround(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              widget: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 110,
                          height: 110,
                          child: ClipOval(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white30,
                                  width: 2,
                                ),
                              ),
                              child:
                                  user.profilePictureUrl != null &&
                                          user.profilePictureUrl!.isNotEmpty
                                      ? Image.network(
                                        user.profilePictureUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.white,
                                          );
                                        },
                                      )
                                      : const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                        ),
                      ),
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(thickness: 2, color: Colors.white30),
                      const SizedBox(height: 10),
                      ProfileTile(
                        icon: Icons.edit,
                        title: "Edit Profile",
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const EditProfilePage(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      ),
                      ProfileTile(
                        icon: Icons.shopping_cart,
                        title: "Cart Page",
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Icons.favorite,
                        title: "Favourites",
                        onTap: () {},
                      ),
                      ProfileTile(
                        icon: Icons.list_alt,
                        title: "Orders",
                        onTap: () {},
                      ),
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
                      ProfileTile(
                        icon: Icons.logout,
                        title: "Sign Out",
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          GoogleSignIn().signOut();
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushReplacementNamed('/login');
                          } else {
                            Navigator.pushReplacementNamed(
                              context,
                              '/profilePage',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Something went Wrong",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white54,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
