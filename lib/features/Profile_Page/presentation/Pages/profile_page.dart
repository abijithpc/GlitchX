import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/Theme/theme_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/Theme/theme_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profilebloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/profile_detail_section.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/profile_tile.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("My Account", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              final currentAppTheme = context.read<ThemeBloc>().state.appTheme;
              final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
              context.read<ThemeBloc>().add(
                ToggleThemeEvent(uid, currentAppTheme),
              );
            },
            icon: Icon(Icons.mode_night),
          ),
        ],
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
            return buildShimmerLoading();
          } else if (state is ProfileLoaded) {
            return ScreenBackGround(
              alignment: Alignment.center,
              screenHeight: MediaQuery.of(context).size.height,
              screenWidth: MediaQuery.of(context).size.width,
              widget: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      ProfileDetailsSection(user: state.user),
                      ProfileTile(
                        icon: Icons.logout,
                        title: "Sign Out",
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder:
                                (context) => CupertinoAlertDialog(
                                  insetAnimationCurve: Curves.fastOutSlowIn,
                                  title: Text("Sign Out"),
                                  content: Text(
                                    "Are you sure you want to sign out? ",
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () => _signOut(),
                                      textStyle: TextStyle(color: Colors.red),
                                      child: Text("Sign Out"),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () => Navigator.pop(context),
                                      textStyle: TextStyle(color: Colors.green),
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                          );
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

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Loginpage()),
      (route) => false,
    );
  }
}
