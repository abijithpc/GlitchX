abstract class ChatbotRepository {
  Future<String> sendMessage(String sessionId, String message);
}