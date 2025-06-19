import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profilebloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/profile_details_field.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/widget/profile_details_header.dart';

class ProfileDetailspage extends StatefulWidget {
  const ProfileDetailspage({super.key});

  @override
  State<ProfileDetailspage> createState() => _ProfileDetailspageState();
}

class _ProfileDetailspageState extends State<ProfileDetailspage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ScreenBackGround(
        alignment: Alignment.center,
        screenWidth: MediaQuery.of(context).size.width,
        screenHeight: MediaQuery.of(context).size.height,
        widget: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return buildShimmerLoading();
            } else if (state is ProfileLoaded) {
              final user = state.user;

              return FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "👋 Welcome back!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(height: 30),
                      ProfileHeader(
                        username: user.username,
                        email: user.email,
                        imageUrl: user.profilePictureUrl,
                      ),
                      const SizedBox(height: 24),
                      ProfileField(
                        title: "Username",
                        value: user.username,
                        icon: Icons.person,
                      ),
                      ProfileField(
                        title: "Email",
                        value: user.email,
                        icon: Icons.email,
                      ),
                      ProfileField(
                        title: "Phone",
                        value: user.mobile,
                        icon: Icons.phone,
                      ),
                      ProfileField(
                        title: "User ID",
                        value: user.id,
                        icon: Icons.badge,
                      ),
                      ProfileField(
                        title: "Location",
                        value: user.location!,
                        icon: Icons.badge,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
