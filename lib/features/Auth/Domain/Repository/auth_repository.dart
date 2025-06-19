import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';

abstract class AuthRepository {
  Future<Usermodels> signUp({
    required String username,
    required String email,
    required String password,
    required String mobileNumber,
  });

  Future<Usermodels> login({required String email, required String password});

  Future<void> sendEmailVerification();

  Future<void> resetPassword(String email);

  Future<bool> isEmailVerified();

  Future<Usermodels> signInWithGoogle();

}
