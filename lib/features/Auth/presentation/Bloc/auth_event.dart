abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String mobileNumber;

  SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.mobileNumber,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent(this.email);
}

class CheckEmailVerificationEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}
