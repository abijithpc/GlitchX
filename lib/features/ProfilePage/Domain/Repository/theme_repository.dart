import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';

abstract class ThemeRepository {
  Future<AppTheme> getTheme(String uid);
  Future<void> setTheme(String uid, AppTheme theme);
}
