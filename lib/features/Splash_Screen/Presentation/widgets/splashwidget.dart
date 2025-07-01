import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class SplashContainer extends StatelessWidget {
  final String heading;
  final String description;
  final String backgroundImage; // Portrait
  final String? landscapeImage; // For web landscape
  final double screenWidth;
  final double screenHeight;

  const SplashContainer({
    super.key,
    required this.heading,
    required this.description,
    required this.backgroundImage,
    this.landscapeImage,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscapeWeb = kIsWeb && screenWidth > screenHeight;
    final String imageToUse =
        isLandscapeWeb && landscapeImage != null
            ? landscapeImage!
            : backgroundImage;

    final double headingFont = screenWidth * (kIsWeb ? 0.05 : 0.08);
    final double descriptionFont = screenWidth * (kIsWeb ? 0.025 : 0.035);
    final double paddingHorizontal = screenWidth * 0.06;
    final double paddingVertical = screenHeight * 0.08;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageToUse),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth > 800 ? 600 : double.infinity,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                    fontSize: headingFont,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: descriptionFont,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
