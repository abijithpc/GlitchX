import 'package:flutter/material.dart';

Widget sectionTitle(String title, bool isTablet) {
  return Text(
    title,
    style: TextStyle(
      fontSize: isTablet ? 26 : 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
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
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: child,
  );
}
