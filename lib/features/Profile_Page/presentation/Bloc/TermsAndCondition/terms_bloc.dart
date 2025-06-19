import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/termscondition_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/TermsAndCondition/terms_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/TermsAndCondition/terms_state.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  final TermsconditionUsecase _termsconditionUsecase;

  TermsBloc(this._termsconditionUsecase) : super(TermsInitial()) {
    on<LoadTermsEvent>((event, emit) async {
      emit(TermsLoading());
      try {
        final terms = await _termsconditionUsecase();
        print("Terms and Condition : $terms");
        emit(TermsLoaded(terms.Terms));
      } catch (e) {
        print("Error is : ${e.toString()}");
        emit(TermsError(e.toString()));
      }
    });
  }
}
