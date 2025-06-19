import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/DataSource/theme_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/theme_repository.dart';

class ThemeReposiotryimpl implements ThemeRepository {
  final ThemeRemoteDataSourceImpl remotedatasource;

  ThemeReposiotryimpl(this.remotedatasource);

  @override
  Future<void> setTheme(String uid, AppTheme theme) {
    return remotedatasource.setTheme(uid, theme);
  }

  @override
  Future<AppTheme> getTheme(String uid) {
    return remotedatasource.getTheme(uid);
  }
}
