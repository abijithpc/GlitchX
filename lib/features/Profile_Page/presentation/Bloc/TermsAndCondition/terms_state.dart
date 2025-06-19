abstract class TermsState {}

class TermsInitial extends TermsState {}

class TermsLoading extends TermsState {}

class TermsLoaded extends TermsState {
  final String content;

  TermsLoaded(this.content);
}

class TermsError extends TermsState {
  final String message;

  TermsError(this.message);
}
