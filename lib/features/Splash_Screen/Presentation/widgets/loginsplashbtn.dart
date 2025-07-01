import 'package:flutter/material.dart';

class LoginSplashBtn extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const LoginSplashBtn({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonFont = screenWidth * 0.015;
    final double verticalPadding = screenHeight * 0.02;

    return Container(
      height: screenHeight * 0.1,
      width: screenWidth,
      decoration: const BoxDecoration(color: Colors.black),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: verticalPadding,
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: screenHeight * 0.015,
              horizontal: screenWidth * 0.05,
            ),
          ),
          backgroundColor: const WidgetStatePropertyAll<Color>(
            Colors.blueAccent,
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: Text(
          "Tap to Login",
          style: TextStyle(
            fontSize: buttonFont,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
