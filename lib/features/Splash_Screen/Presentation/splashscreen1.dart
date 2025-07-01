import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen1 extends StatefulWidget {
  const Splashscreen1({super.key});

  @override
  State<Splashscreen1> createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen1> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        checkUser();
      });
    });
  }

  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 3));

    await FirebaseAuth.instance.authStateChanges().first;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.reload();
        final refreshedUser = FirebaseAuth.instance.currentUser;

        if (refreshedUser != null) {
          Navigator.pushReplacementNamed(context, '/bottomNav');
        } else {
          Navigator.pushReplacementNamed(context, '/splash2');
        }
      } catch (e) {
        Navigator.pushReplacementNamed(context, '/splash2');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/splash2');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.25; // 25% of screen height
    final double textSize = size.width * 0.08; // 8% of screen width

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: imageHeight,
                child: Image.asset(
                  'Assets/Logo/Untitled_design-removebg-preview.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: size.height * 0.05), // spacing
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: textSize,
                  letterSpacing: 5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [WavyAnimatedText("GlitchX")],
                  isRepeatingAnimation: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
