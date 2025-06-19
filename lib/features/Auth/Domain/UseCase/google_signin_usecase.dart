import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<Usermodels> call() async {
    return await repository.signInWithGoogle();
  }
}
