import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/privacy_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/PrivacyBloc/privacy_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/PrivacyBloc/privacy_state.dart';

class PrivacyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  final PrivacyPolicyUsecase policyUsecase;

  PrivacyBloc(this.policyUsecase) : super(PrivacyPolicyInitial()) {
    on<LoadPrivacyPolicy>((event, emit) async {
      emit(PrivacyPolicyLoading());
      try {
        final policy = await policyUsecase();
        emit(PrivacyPolicyLoaded(policy.content));
      } catch (e) {
        emit(PrivacyPolicyError(e.toString()));
      }
    });
  }
}
