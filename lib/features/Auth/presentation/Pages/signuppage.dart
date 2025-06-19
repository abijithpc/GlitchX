import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_state.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/singup_form.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/singup_helper.dart';

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
            SignupHelpers.showSnackBar(context, state.message);
          } else if (state is AuthLoading) {
            SignupHelpers.showLoadingDialog(context);
          } else if (state is SignupSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            SignupHelpers.navigateToVerifyEmail(context, state.user);
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ScreenBackGround(
              alignment: Alignment.center,
              screenHeight: constraints.maxHeight,
              screenWidth: constraints.maxWidth,
              widget: SignupForm(
                formKey: _formKey,
                usernameController: _usernameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                mobileNumberController: _mobileNumberController,
              ),
            );
          },
        ),
      ),
    );
  }
}
