import 'package:glitchxscndprjt/features/Ai_Page/Data/DataSource/dialogflow_remote_data_source.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/chatbot_repository.dart';

class ChatbotRepositoryimpl implements ChatbotRepository {
  final DialogflowRemoteDataSource _remoteDataSource;

  ChatbotRepositoryimpl(this._remoteDataSource);

  @override
  Future<String> sendMessage(String sessionId, String message) {
    return _remoteDataSource.detectIntent(sessionId, message);
  }
}
