part of 'theme_bloc.dart';

enum AppTheme { light, dark }

class ThemeState extends Equatable {
  final AppTheme appTheme;

  ThemeState({this.appTheme = AppTheme.light});

  @override
  List<Object> get props => [appTheme];

  factory ThemeState.initial() {
    return ThemeState();
  }

  @override
  String toString() {
    return 'ThemeState(appTheme: $appTheme)';
  }

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
