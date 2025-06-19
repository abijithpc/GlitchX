import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/privacy_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/termcondtion_model.dart';

abstract class PrivacyPolicyRepository {
  Future<PrivacyPolicy> getPrivacyPolicy();
  Future<TermcondtionModel> getTermsAndCondition();
}
