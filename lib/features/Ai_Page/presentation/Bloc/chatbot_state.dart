import 'package:equatable/equatable.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/Models/chat_message.dart';

abstract class ChatbotState extends Equatable {
  final List<ChatMessage> messages;

  const ChatbotState(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial() : super(const []);
}

class ChatbotLoading extends ChatbotState {
  const ChatbotLoading(List<ChatMessage> messages) : super(messages);
}

class ChatbotLoaded extends ChatbotState {
  const ChatbotLoaded(List<ChatMessage> messages) : super(messages);
}

class ChatbotError extends ChatbotState {
  final String error;

  const ChatbotError(List<ChatMessage> messages, this.error) : super(messages);

  @override
  List<Object> get props => [messages, error];
}
