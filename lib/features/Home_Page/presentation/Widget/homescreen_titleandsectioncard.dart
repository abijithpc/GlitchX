import 'package:flutter/material.dart';

Widget sectionTitle(String title, bool isTablet, Color colors) {
  return Text(
    title,
    style: TextStyle(
      fontSize: isTablet ? 26 : 18,
      fontWeight: FontWeight.bold,
      color: colors,
      letterSpacing: 0.5,
    ),
  );
}

Widget buildSectionCard(double screenWidth, {required Widget child}) {
  return Container(
    width: screenWidth,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(15), // ~6% opacity
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white.withAlpha(25)), // ~10% opacity
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(51), // ~20% opacity
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: child,
  );
}

Widget buildSectionPopularCard(double screenWidth, {required Widget child}) {
  return Container(
    width: screenWidth,
    // padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(vertical: 6),

    child: child,
  );
}
