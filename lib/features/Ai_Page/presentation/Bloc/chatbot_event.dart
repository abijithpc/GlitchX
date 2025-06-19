import 'package:equatable/equatable.dart' show Equatable;

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatbotEvent {
  final String sessionId;
  final String message;

  const SendMessageEvent({required this.sessionId, required this.message});

  @override
  List<Object> get props => [sessionId, message];
}
