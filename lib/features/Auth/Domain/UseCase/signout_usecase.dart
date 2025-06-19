// features/Auth/Domain/UseCase/signout_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glitchxscndprjt/Core/Error/failure.dart';

class SignoutUsecase {
  final FirebaseAuth _auth;

  // Constructor with optional FirebaseAuth parameter for testing
  SignoutUsecase({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  // The call method that makes this class callable
  Future<Either<Failure, void>> call() async {
    try {
      await _auth.signOut();
      return const Right(null); // Success case returns Right with no value
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Sign out failed'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}