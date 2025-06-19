import 'package:flutter/services.dart';

class PrivacyPolicyLocalDataSource {
  Future<String> getPrivacyPolicyMarkdown() async {
    return await rootBundle.loadString(
      'Assets/Terms_And_Privacy_Policy/Privacy&Policy.md',
    );
  }

  Future<String> getTermAndConditon() async {
    return await rootBundle.loadString(
      'Assets/Terms_And_Privacy_Policy/Terms&Conditions.md',
    );
  }
}
