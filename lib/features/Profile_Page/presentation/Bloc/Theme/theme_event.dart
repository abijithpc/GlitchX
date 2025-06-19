import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';

abstract class ThemeEvent {}

class LoadThemeEvent extends ThemeEvent {
  final String uid;
  LoadThemeEvent(this.uid);
}

class ToggleThemeEvent extends ThemeEvent {
  final String uid;
  final AppTheme currentTheme;
  ToggleThemeEvent(this.uid, this.currentTheme);
}
