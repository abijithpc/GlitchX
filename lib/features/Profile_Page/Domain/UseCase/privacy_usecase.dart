import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/privacy_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/privacy_repository.dart';

class PrivacyPolicyUsecase {
  final PrivacyPolicyRepository _policyRepository;

  PrivacyPolicyUsecase(this._policyRepository);

  Future<PrivacyPolicy> call() async {
    return _policyRepository.getPrivacyPolicy();
  }
}
