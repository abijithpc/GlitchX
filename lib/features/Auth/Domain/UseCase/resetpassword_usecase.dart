import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';

class ResetpasswordUsecase {
  final AuthRepository repository;

  ResetpasswordUsecase(this.repository);

  Future<void> call( String email){
    return repository.resetPassword(email);
  }
}