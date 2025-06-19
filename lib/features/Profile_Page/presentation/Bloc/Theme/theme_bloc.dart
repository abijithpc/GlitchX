// theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/Ennum/ennum.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/get_theme_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/settheme_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/Theme/theme_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/Theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUsecase getThemeUsecase;
  final SetThemeUsecase setThemeUsecase;

  ThemeBloc(this.getThemeUsecase, this.setThemeUsecase)
    : super( ThemeState(AppTheme.light)) {
    on<LoadThemeEvent>((event, emit) async {
      final appTheme = await getThemeUsecase(event.uid);
      emit(ThemeState(appTheme));
    });

    on<ToggleThemeEvent>((event, emit) async {
      final newTheme =
          event.currentTheme == AppTheme.dark ? AppTheme.light : AppTheme.dark;

      await setThemeUsecase(event.uid, newTheme);
      emit(ThemeState(newTheme));
    });
  }
}
