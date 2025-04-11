// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:glitchxscndprjt/features/Auth/presentation/Widget/loginbtn.dart';

// class LoginForm extends StatelessWidget {
//   const LoginForm({
//     super.key,
//     required this.screenHeight,
//     required this.screenWidth,
//   });

//   final double screenHeight;
//   final double screenWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Welcome Back 👋",
//             style: TextStyle(
//               fontSize: screenHeight * 0.035,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Login to continue",
//             style: TextStyle(
//               fontSize: screenHeight * 0.02,
//               color: Colors.white70,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.04),

//           // Email Field
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: "Email",
//                 labelText: "Email Address",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.03),

//           // Password Field
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: "Password",
//                 labelText: "Enter Your Password",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.015),

//           Align(
//             alignment: Alignment.centerRight,
//             child: GestureDetector(
//               onTap: () {},
//               child: Text(
//                 "Forgot Password?",
//                 style: TextStyle(
//                   color: Colors.white,
//                   decoration: TextDecoration.underline,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.04),

//           // Login Button
//           LoginBtn(screenHeight: screenHeight, screenWidth: screenWidth),

//           SizedBox(height: screenHeight * 0.04),

//           Row(
//             children: <Widget>[
//               Expanded(child: Divider(color: Colors.grey, thickness: 1)),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   "Or Login With",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//               Expanded(child: Divider(color: Colors.grey, thickness: 1)),
//             ],
//           ),

//           SizedBox(height: screenHeight * 0.04),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: screenWidth * 0.44,
//                 height: screenHeight * 0.06,
//                 child: ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: Image.asset(
//                     'Assets/Auth_Icon/icons8-google-48.png',
//                     width: 24,
//                     height: 24,
//                   ),
//                   label: Text('Google'),
//                 ),
//               ),
//               SizedBox(
//                 width: screenWidth * 0.44,
//                 height: screenHeight * 0.06,
//                 child: ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: Image.asset(
//                     'Assets/Auth_Icon/icons8-facebook-48.png',
//                     width: 24,
//                     height: 24,
//                   ),
//                   label: Text('Facebook'),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: screenHeight * 0.04),

//           // Optional Signup Prompt
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Don't have an account?",
//                 style: TextStyle(color: Colors.white70),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/signup');
//                 },
//                 child: Text("Sign Up"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
