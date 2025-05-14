import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenBackGround extends StatelessWidget {
  ScreenBackGround({
    required this.widget,
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.alignment,
  });

  final double screenHeight;
  final double screenWidth;
  Widget widget;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.1, 0.5, 0.9], // Define stops to create smooth transitions
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF404040), // Dark Ash
            const Color(0xFF2C2C2C), // Coal
            const Color(0xFF101010), // Very Dark Gray
          ],
        ),
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget,
        ),
      ),
    );
  }
}
          // const Color(0xFF2E2E2E), // Charcoal
          //   const Color(0xFF1C1C1C), // Very Dark Gray
          //   const Color(0xFF000000), // Black