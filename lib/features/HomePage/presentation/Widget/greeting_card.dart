import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/homescreen_titleandsectioncard.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/popular_game_card.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({
    super.key,
    required this.screenWidth,
    required this.userPic,
    required this.greetingMessage,
    required this.username,
    required this.isTablet,
    required this.currentDate,
  });

  final double screenWidth;
  final String userPic;
  final String greetingMessage;
  final String username;
  final bool isTablet;
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
