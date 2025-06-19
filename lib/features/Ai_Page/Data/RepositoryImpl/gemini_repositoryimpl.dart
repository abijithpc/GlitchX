import 'package:glitchxscndprjt/features/Ai_Page/Data/DataSource/gemini_api.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/gemini_repository.dart';

class GeminiRepositoryimpl implements GeminiRepository {
  final GeminiRemoteDataSource remoteDataSource;

  GeminiRepositoryimpl(this.remoteDataSource);

  @override
  Future<String> sendPrompt(String prompt) async {
    return await remoteDataSource.sendPrompt(prompt);
  }
}
