import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_event.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_state.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/reset_password.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/signuppage.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Widget/bottomnavigation_bar.dart';
import 'package:lottie/lottie.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthError) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text("Login Failed"),
                    content: SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.3,
                      child: Column(
                        children: [
                          Lottie.asset(
                            'Assets/Animation/Animation - 1744347144801.json',
                            width: 160,
                            height: 160,
                            repeat: false,
                          ),
                          const SizedBox(height: 16),
                          Text(state.message),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("OK"),
                      ),
                    ],
                  ),
            );
          } else if (state is LoginSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PersistentBottomNavigationBar(),
              ),
            );
          }
        },
        builder: (context, state) {
          return ScreenBackGround(
            alignment: Alignment.center,
            widget: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back 👋",
                      style: TextStyle(
                        fontSize: screenHeight * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Login to continue",
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Email Field
                    Material(
                      elevation: 5,
                      shadowColor: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          labelText: "Email Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Password Field
                    Material(
                      elevation: 5,
                      shadowColor: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          labelText: "Enter Your Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Login Button
                    SizedBox(
                      height: screenHeight * 0.06,
                      width: screenWidth,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            Color(0xFF25006A),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or Login With",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.60,
                        height: screenHeight * 0.06,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              GoogleSignInRequested(),
                            );
                          },
                          icon: Image.asset(
                            'Assets/Auth_Icon/icons8-google-48.png',
                            width: 24,
                            height: 24,
                          ),
                          label: Text('Sign In with Google'),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signuppage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          );
        },
      ),
    );
  }
}
