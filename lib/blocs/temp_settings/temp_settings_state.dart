part of 'temp_settings_bloc.dart';

enum TempUnit { celsius, fahrenheit }

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;

  TempSettingsState({required this.tempUnit});

  @override
  List<Object> get props => [tempUnit];

  factory TempSettingsState.initial() {
    return TempSettingsState(tempUnit: TempUnit.celsius);
  }

  @override
  String toString() {
    return 'TempSettingsState(tempUnit: $tempUnit)';
  }

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
