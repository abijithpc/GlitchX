import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/UseCase/gemini_usecase.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/Gemini/gemini_event.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/Gemini/gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent,GeminiState> {
final SendPromptUsecase sendPromptUsecase;
  GeminiBloc(this.sendPromptUsecase) : super(ChatInitial()){
    on<SendPromptEvent>((event, emit) async{
      emit(ChatLoading());
      try {
        final response = await sendPromptUsecase(event.prompt);
        emit(ChatLoaded(response));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    },);
  }
  
}