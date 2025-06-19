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
      Future.delayed(Duration(seconds: 3), () {
        checkUser();
      });
    });
  }

  Future<void> checkUser() async {
    await Future.delayed(Duration(seconds: 3));

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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Assets/Logo/Untitled_design-removebg-preview.png'),
              DefaultTextStyle(
                style: TextStyle(fontSize: 30, letterSpacing: 5),
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
