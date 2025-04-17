import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/verify_emailpage.dart';

class SignupHelpers {
  static Widget buildLoginRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an Account?',
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Loginpage()),
              ),
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.greenAccent),
          ),
        ),
      ],
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void navigateToVerifyEmail(BuildContext context, dynamic user) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => VerifyEmailPage(user: user)),
    );
  }
}
