import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/emailverification_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/google_signin_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/login_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/resetpassword_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/signup_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final EmailverificationUsecase emailVerificationUsecase;
  final ResetpasswordUsecase resetPasswordUsecase;
  final AuthRepository authRepository;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  AuthBloc({
    required this.signupUsecase,
    required this.loginUsecase,
    required this.emailVerificationUsecase,
    required this.resetPasswordUsecase,
    required this.authRepository,
    required this.signInWithGoogleUseCase,
  }) : super(AuthIntial()) {
    // SignUp Event
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());

      if (event.password != event.confirmPassword) {
        emit(AuthError('Password do not Match'));
        return;
      }

      try {
        final userModel = await signupUsecase.call(
          username: event.username,
          email: event.email,
          password: event.password,
          mobileNumber: event.mobileNumber,
        );

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(AuthError("User not found after Signup"));
          return;
        }
        emit(SignupSuccess(user: userModel, firebaseUser: user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUsecase.call(
          email: event.email,
          password: event.password,
        );
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser == null) {
          emit(AuthError("Login Failed. Please try Again"));
          return;
        }

        if (!currentUser.emailVerified) {
          emit(AuthError('Please verify Your email Before logging in'));
        }

        emit(LoginSuccess(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Reset Password Event
    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await resetPasswordUsecase.call(event.email);
        emit(ResetPasswordEmailSent());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Check Email Verification Event
    on<CheckEmailVerificationEvent>((event, emit) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user?.reload(); // force reload to update emailVerified flag
        final updatedUser = FirebaseAuth.instance.currentUser;

        final isVerified = updatedUser?.emailVerified ?? false;

        if (isVerified) {
          emit(
            AuthEmailVerifiedState(),
          ); // Email is verified, proceed to login screen
        } else {
          emit(SendEmailVerificationStatus(false)); // Not verified yet
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final googleusermodel = await authRepository.signInWithGoogle();
        final firebaseUser = FirebaseAuth.instance.currentUser;

        if (firebaseUser == null) {
          emit(AuthError("Google Sign In Failed"));
          return;
        }

        emit(LoginSuccess(googleusermodel));
      } catch (e) {
        emit(AuthError("Google Sing-In Failed: ${e.toString()}"));
      }
    });
  }
}
