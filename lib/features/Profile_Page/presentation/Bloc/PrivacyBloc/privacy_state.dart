abstract class PrivacyPolicyState {}

class PrivacyPolicyInitial extends PrivacyPolicyState {}

class PrivacyPolicyLoading extends PrivacyPolicyState {}

class PrivacyPolicyLoaded extends PrivacyPolicyState {
  final String content;

  PrivacyPolicyLoaded(this.content);
}

class PrivacyPolicyError extends PrivacyPolicyState {
  final String message;

  PrivacyPolicyError(this.message);
}
