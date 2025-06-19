import 'package:glitchxscndprjt/features/Auth/Data/DataSource/firebase_auth_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';
import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Usermodels> signUp({
    required String username,
    required String email,
    required String password,
    required String mobileNumber,
  }) async {
    return await remoteDataSource.signUp(
      username: username,
      email: email,
      password: password,
      mobileNumber: mobileNumber,
    );
  }

  @override
  Future<Usermodels> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> resetPassword(String email) async {
    return await remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> sendEmailVerification() async {
    return await remoteDataSource.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    return await remoteDataSource.isEmailVerified();
  }

  @override
  Future<Usermodels> signInWithGoogle() async {
    return await remoteDataSource.signInWithGoogle();
  }
}
