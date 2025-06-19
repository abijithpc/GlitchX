import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';

class BlockedScreen extends StatelessWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.block, color: Colors.red, size: 80),
            SizedBox(height: 20),
            Text(
              "We're sorry, but your account has been temporarily blocked.",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "This may be due to a violation of our terms of service or suspicious activity. If you believe this is a mistake, please contact our support team for further assistance..",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Log Out', style: TextStyle(fontSize: 20)),
                IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
