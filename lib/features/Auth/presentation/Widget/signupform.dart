// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_bloc.dart';
// import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_event.dart';
// import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';

// class SignUpForm extends StatelessWidget {
//   SignUpForm({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _mobileNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "Sign Up",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             "Create your account to continue",
//             style: TextStyle(color: Colors.white70),
//           ),
//           SizedBox(height: 30),
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               controller: _usernameController,
//               keyboardType: TextInputType.name,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.person_outline),
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: "Username",
//                 labelText: "Username",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Please enter a username";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.025),
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.email_outlined),
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: "Email",
//                 labelText: "Email Address",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Please enter a Email Address";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.025),
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               keyboardType: TextInputType.visiblePassword,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.lock_outline),
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: "Password",
//                 labelText: "Password",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Please enter a Password";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.025),
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               keyboardType: TextInputType.visiblePassword,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.lock_reset),
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: "Confirm Password",
//                 labelText: "Confirm Password",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Please enter a Password";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.025),
//           Material(
//             elevation: 5,
//             shadowColor: Colors.black45,
//             borderRadius: BorderRadius.circular(12),
//             child: TextFormField(
//               controller: _mobileNumberController,
//               obscureText: true,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.lock_reset),
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: "Mobile Number",
//                 labelText: "Mobile Number",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return "Please enter a Mobile Number";
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.035),
//           SizedBox(
//             height: screenHeight * 0.06,
//             width: screenWidth,
//             child: TextButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   BlocProvider.of<AuthBloc>(context).add(
//                     SignUpEvent(
//                       username: _usernameController.text,
//                       email: _emailController.text,
//                       password: _passwordController.text,
//                       confirmPassword: _confirmPasswordController.text,
//                       mobileNumber: _mobileNumberController.text,
//                     ),
//                   );
//                 }
//               },
//               style: ButtonStyle(
//                 backgroundColor: WidgetStatePropertyAll<Color>(
//                   Color(0xFF25006A),
//                 ),
//                 shape: WidgetStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               child: Text(
//                 "Sign Up",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.06),
//           Row(
//             children: [
//               Expanded(child: Divider(color: Colors.white60, thickness: 1)),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Text("or", style: TextStyle(color: Colors.white70)),
//               ),
//               Expanded(child: Divider(color: Colors.white60, thickness: 1)),
//             ],
//           ),
//           SizedBox(height: screenHeight * 0.04),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Already have an Account?',
//                 style: TextStyle(color: Colors.white),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/login');
//                 },
//                 child: Text(
//                   'Login',
//                   style: TextStyle(color: Colors.greenAccent),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
