import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/Models/chat_message.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/chatbot_repository.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/chatbot_event.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final ChatbotRepository repository;

  ChatbotBloc(this.repository) : super(ChatbotInitial()) {
    on<SendMessageEvent>((event, emit) async {

      final currentMessages = List<ChatMessage>.from(state.messages)
        ..add(ChatMessage(text: event.message, sender: Sender.user));

      emit(ChatbotLoaded(currentMessages));

      try {
        emit(ChatbotLoading(currentMessages));

        final response = await repository.sendMessage(
          event.sessionId,
          event.message,
        );

        final updatedMessages = List<ChatMessage>.from(currentMessages)
          ..add(ChatMessage(text: response, sender: Sender.bot));

        emit(ChatbotLoaded(updatedMessages));
      } catch (e) {

        emit(ChatbotError(currentMessages, e.toString()));
      }
    });
  }
}
