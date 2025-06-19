import 'package:flutter/material.dart';

class LoginSplashBtn extends StatelessWidget {
  const LoginSplashBtn({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withAlpha(10)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 80,
      width: screenWidth,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.blueAccent),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Text("Tap to Login", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
