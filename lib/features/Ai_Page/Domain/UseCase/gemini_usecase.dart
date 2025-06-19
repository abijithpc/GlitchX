import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/gemini_repository.dart';

class SendPromptUsecase {
  final GeminiRepository repository;

  SendPromptUsecase(this.repository);
  
  Future<String> call(String prompt) async {
    return await repository.sendPrompt(prompt);
  }
}
