import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';

abstract class AuthState {}

class AuthIntial extends AuthState {}

class AuthLoading extends AuthState {}

class SignupSuccess extends AuthState {
  final Usermodels user;
  final User firebaseUser;

  SignupSuccess({required this.user, required this.firebaseUser});

  List<Object?> get props => [user, firebaseUser];
}

class LoginSuccess extends AuthState {
  final Usermodels user;

  LoginSuccess(this.user);
}

class SignOutSuccess extends AuthState {
  List<Object> get props => [];
}

class ResetPasswordEmailSent extends AuthState {}

class SendEmailVerificationStatus extends AuthState {
  final bool isVerified;

  SendEmailVerificationStatus(this.isVerified);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthEmailVerifiedState extends AuthState {
  final String message;

  AuthEmailVerifiedState({this.message = "Email has been verified"});
}

class AuthSuccess extends AuthState {}
