import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/chatbot_repository.dart';

class SendMessageUseCase {
  final ChatbotRepository _repository;

  SendMessageUseCase(this._repository);

  Future<String> call(String sessionId, String message) {
    return _repository.sendMessage(sessionId, message);
  }
}
