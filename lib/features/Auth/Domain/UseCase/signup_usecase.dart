import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  Future<Usermodels> call({
    required String username,
    required String email,
    required String password,
    required String mobileNumber,
  }) {
    return repository.signUp(
      username: username,
      email: email,
      password: password,
      mobileNumber: mobileNumber,
    );
  }
}
