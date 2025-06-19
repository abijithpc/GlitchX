import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/theme_repository.dart';

class GetThemeUsecase {
  final ThemeRepository repository;

  GetThemeUsecase(this.repository);

  Future<AppTheme> call(String uid) {
    return repository.getTheme(uid);
  }
}
