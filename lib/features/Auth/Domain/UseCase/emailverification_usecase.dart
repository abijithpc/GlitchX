import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';

class EmailverificationUsecase {
final AuthRepository repository;
  EmailverificationUsecase(this.repository);

  Future<void> sendEmailVerification() {
    return repository.sendEmailVerification();
  }

  Future<bool> isEmailVerified() {
    return repository.isEmailVerified();
  }
}
