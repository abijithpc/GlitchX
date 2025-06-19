import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/termcondtion_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/privacy_repository.dart';

class TermsconditionUsecase {
  final PrivacyPolicyRepository repository;

  TermsconditionUsecase(this.repository);

  Future<TermcondtionModel> call() async {
    return repository.getTermsAndCondition();
  }
}
