import 'package:glitchxscndprjt/features/Profile_Page/Data/DataSource/privacy_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/privacy_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/termcondtion_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/privacy_repository.dart';

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  final PrivacyPolicyLocalDataSource localDataSource;

  PrivacyPolicyRepositoryImpl(this.localDataSource);

  @override
  Future<PrivacyPolicy> getPrivacyPolicy() async {
    final content = await localDataSource.getPrivacyPolicyMarkdown();
    return PrivacyPolicy(content);
  }

  @override
  Future<TermcondtionModel> getTermsAndCondition() async {
    final Terms = await localDataSource.getTermAndConditon();
    return TermcondtionModel(Terms);
  }
}
