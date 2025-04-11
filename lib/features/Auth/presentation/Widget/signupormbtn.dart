// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';

// class SignUpForm extends StatelessWidget {
//   const SignUpForm({
//     super.key,
//     required this.screenHeight,
//     required this.screenWidth,
//   });

//   final double screenHeight;
//   final double screenWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Material(
//           elevation: 5,
//           shadowColor: Colors.black45,
//           borderRadius: BorderRadius.circular(12),
//           child: TextFormField(
//             keyboardType: TextInputType.name,
//             decoration: InputDecoration(
//               fillColor: Colors.white,
//               filled: true,
//               hintText: "Username",
//               labelText: "Username",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.03),
//         Material(
//           elevation: 5,
//           shadowColor: Colors.black45,
//           borderRadius: BorderRadius.circular(12),
//           child: TextFormField(
//             keyboardType: TextInputType.name,
//             decoration: InputDecoration(
//               fillColor: Colors.white,
//               filled: true,
//               hintText: "Email",
//               labelText: "Email Address",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.03),
//         Material(
//           elevation: 5,
//           shadowColor: Colors.black45,
//           borderRadius: BorderRadius.circular(12),
//           child: TextFormField(
//             keyboardType: TextInputType.name,
//             decoration: InputDecoration(
//               fillColor: Colors.white,
//               filled: true,
//               hintText: "Password",
//               labelText: "Password",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.03),
//         Material(
//           elevation: 5,
//           shadowColor: Colors.black45,
//           borderRadius: BorderRadius.circular(12),
//           child: TextFormField(
//             keyboardType: TextInputType.name,
//             decoration: InputDecoration(
//               fillColor: Colors.white,
//               filled: true,
//               hintText: "Confirm Password",
//               labelText: "Confirm Password",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.03),

//         SizedBox(
//           height: screenHeight * 0.06,
//           width: screenWidth,
//           child: TextButton(
//             onPressed: () {},
//             style: ButtonStyle(
//               backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF25006A)),
//             ),
//             child: Text("SignUp", style: TextStyle(color: Colors.white)),
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.07),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Already have an Account',
//               style: TextStyle(color: Colors.white),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   CupertinoPageRoute(builder: (context) => Loginpage()),
//                 );
//               },
//               child: Text('Login', style: TextStyle(color: Colors.green)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
