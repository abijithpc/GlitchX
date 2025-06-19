import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/signup_form_field.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/signupbtn.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/singup_helper.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController mobileNumberController;

  const SignupForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.mobileNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          const Text(
            "Create Your Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black26,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(10),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(150),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SignupFormField.buildTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: usernameController,
                    type: TextInputType.name,
                    label: "Username",
                    icon: Icons.person_outline,
                    validator: (value) {
                      String pattern = r'^[a-zA-Z0-9_]+$';
                      RegExp regExp = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return "Please enter username";
                      } else if (!regExp.hasMatch(value)) {
                        return 'Only letters, numbers & underscores allowed';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SignupFormField.buildTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    label: "Email Address",
                    icon: Icons.email_outlined,
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      String pattern =
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                      RegExp regExp = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      } else if (!regExp.hasMatch(value)) {
                        return "Enter valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SignupFormField.buildTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    label: "Password",
                    icon: Icons.lock_outline,
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      } else if (value.length < 6) {
                        return "Minimum 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SignupFormField.buildTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    icon: Icons.lock_reset,
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm password";
                      } else if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SignupFormField.buildTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: mobileNumberController,
                    label: "Mobile Number",
                    icon: Icons.phone,
                    type: TextInputType.phone,
                    validator: (value) {
                      String pattern = r"^\+?[1-9]\d{1,14}$";
                      RegExp regExp = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return "Please enter mobile number";
                      } else if (!regExp.hasMatch(value)) {
                        return "Enter valid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SignupButton(
                    formKey: formKey,
                    usernameController: usernameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    mobileNumberController: mobileNumberController,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          SignupHelpers.buildLoginRedirect(context),
        ],
      ),
    );
  }
}
