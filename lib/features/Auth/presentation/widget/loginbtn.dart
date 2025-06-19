import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.06,
      width: screenWidth,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF25006A)),
        ),
        onPressed: () {},
        child: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
