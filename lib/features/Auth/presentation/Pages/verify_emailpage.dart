import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/features/Auth/Data/DataSource/firebase_auth_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_event.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_state.dart';

class VerifyEmailPage extends StatefulWidget {
  final Usermodels user;

  const VerifyEmailPage({super.key, required this.user});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late Timer _timer;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuthRemoteDataSource _remoteDataSource =
      FirebaseAuthRemoteDataSource(
        auth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      );

  @override
  void initState() {
    super.initState();
    _startEmailCheckTimer();
  }

  void _startEmailCheckTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      BlocProvider.of<AuthBloc>(context).add(CheckEmailVerificationEvent());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthEmailVerifiedState) {
          _timer.cancel();

          // ✅ Save user to Firestore
          await _remoteDataSource.storeUserData(widget.user);

          // ✅ Navigate to login page
          Navigator.pushReplacementNamed(context, '/login');
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.deepPurple.shade50,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:
                  state is AuthLoading
                      ? CircularProgressIndicator()
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 80,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Verify your email",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "A verification email has been sent to your email address.\n\nPlease check your inbox and verify to continue.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }
}
