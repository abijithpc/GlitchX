import 'package:glitchxscndprjt/features/Auth/Data/Models/usermodels.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Usermodels> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
