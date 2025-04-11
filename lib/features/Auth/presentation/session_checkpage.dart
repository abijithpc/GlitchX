// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';
// import 'package:glitchxscndprjt/features/HomePage/homepage.dart';
// import 'package:glitchxscndprjt/features/Splash/Presentation/splashscreen1.dart';

// class SessionCheckpage extends StatelessWidget {
//   const SessionCheckpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Future.delayed(Duration(seconds: 2), () {
//         return FirebaseAuth.instance.currentUser;
//       }),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState != ConnectionState.done) {
//           return Splashscreen1();
//         }
//         if (snapshot.data != null && snapshot.data!.emailVerified) {
//           return Homepage();
//         } else {
//           return Loginpage();
//         }
//       },
//     );
//   }
// }
