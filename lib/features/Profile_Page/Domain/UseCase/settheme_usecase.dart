import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/theme_repository.dart';

class SetThemeUsecase {
  final ThemeRepository repository;

  SetThemeUsecase(this.repository);

  Future<void> call(String uid, AppTheme theme) {
    return repository.setTheme(uid, theme);
  }
}
