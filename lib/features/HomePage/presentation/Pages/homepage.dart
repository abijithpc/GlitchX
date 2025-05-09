import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/choice_chips.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              userPic.isNotEmpty
                                  ? NetworkImage(userPic)
                                  : const AssetImage(
                                        'Assets/Auth_Icon/icon-5359554_1280.png',
                                      )
                                      as ImageProvider,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Text(
                            "$greetingMessage, $username",
                            style: GoogleFonts.lato(
                              fontSize: isTablet ? 24 : 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currentDate,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 14,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              buildSectionCard(
                screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Categories", isTablet),
                    const SizedBox(height: 10),
                    const CatergoryChoiceChips(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              buildSectionCard(
                screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Popular Games", isTablet),
                    const SizedBox(height: 10),
                    const PopularGameCard(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
