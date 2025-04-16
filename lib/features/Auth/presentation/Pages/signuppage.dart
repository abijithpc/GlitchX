import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_state.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/verify_emailpage.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Widget/screenbackground.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthError) {
            _showSnackBar(state.message);
          } else if (state is AuthLoading) {
            _showLoadingDialog();
          } else if (state is SignupSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            _navigateToVerifyEmail(state.user);
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ScreenBackGround(
              screenHeight: constraints.maxHeight,
              screenWidth: constraints.maxWidth,
              widget: _buildSignUpForm(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              controller: _usernameController,
              label: "Username",
              icon: Icons.person_outline,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "Please enter username"
                          : null,
            ),
            _buildTextField(
              controller: _emailController,
              label: "Email Address",
              icon: Icons.email_outlined,
              type: TextInputType.emailAddress,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "Please enter email"
                          : null,
            ),
            _buildTextField(
              controller: _passwordController,
              label: "Password",
              icon: Icons.lock_outline,
              obscure: true,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "Please enter password"
                          : null,
            ),
            _buildTextField(
              controller: _confirmPasswordController,
              label: "Confirm Password",
              icon: Icons.lock_reset,
              obscure: true,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter confirm password";
                if (value != _passwordController.text)
                  return "Password does not match";
                return null;
              },
            ),
            _buildTextField(
              controller: _mobileNumberController,
              label: "Mobile Number",
              icon: Icons.phone,
              type: TextInputType.phone,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "Please enter mobile number"
                          : null,
            ),
            const SizedBox(height: 25),
            _buildSignUpButton(),
            const SizedBox(height: 25),
            _buildLoginRedirect(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType type = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25006A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<AuthBloc>(context).add(
              SignUpEvent(
                username: _usernameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                confirmPassword: _confirmPasswordController.text.trim(),
                mobileNumber: _mobileNumberController.text.trim(),
              ),
            );
          }
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an Account?',
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/login'),
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.greenAccent),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _navigateToVerifyEmail(dynamic user) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => VerifyEmailPage(user: user)),
    );
  }
}
