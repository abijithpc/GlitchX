import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({
    super.key,
    required this.userPic,
    required this.screenWidth,
    required this.greetingMessage,
    required this.username,
    required this.isTablet,
    required this.currentDate,
  });

  final String userPic;
  final double screenWidth;
  final String greetingMessage;
  final String username;
  final bool isTablet;
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage:
              userPic.isNotEmpty
                  ? NetworkImage(userPic)
                  : AssetImage('Assets/Auth_Icon/icon-5359554_1280.png'),
        ),
        SizedBox(width: screenWidth * 0.01),
        Text(
          "$greetingMessage, $username",
          style: GoogleFonts.lato(
            fontSize: isTablet ? 24 : 23,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
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
    );
  }
}
