part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme appTheme;

  ChangeThemeEvent({required this.appTheme});
}
