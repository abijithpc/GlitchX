import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/greeting_card.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/homepage_appbar.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/homescreen_titleandsectioncard.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/popular_game_card.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;
    final isTablet = screenWidth > 600;

    final profile = context.watch<ProfileBloc>().state;

    String location = '';
    String greetingMessage = '';
    String username = '';
    String userPic = '';
    String currentDate = DateFormat('d MMMM, y').format(DateTime.now());

    if (profile is ProfileLoaded) {
      location = profile.user.location ?? 'Location not available';
      username = profile.user.username;
      userPic = profile.user.profilePictureUrl ?? '';
      final hour = DateTime.now().hour;
      if (hour < 12) {
        greetingMessage = 'Good Morning';
      } else if (hour < 17) {
        greetingMessage = 'Good Afternoon';
      } else {
        greetingMessage = 'Good Evening';
      }
    }

    return Scaffold(
      appBar: HomePage_AppBar(location),
      body: ScreenBackGround(
        alignment: Alignment.topCenter,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        widget: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: screenWidth * 0.08,
            bottom: screenHeight * 0.02,
          ),
          child: GreetingCard(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            userPic: userPic,
            greetingMessage: greetingMessage,
            username: username,
            isTablet: isTablet,
            currentDate: currentDate,
          ),
        ),
      ),
    );
  }
}
