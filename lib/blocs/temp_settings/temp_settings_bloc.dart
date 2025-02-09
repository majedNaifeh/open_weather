import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_event.dart';
part 'temp_settings_state.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingsState> {
  TempSettingsBloc() : super(TempSettingsState.initial()) {
    on<ToggleTempUnitEvent>((event, emit) {
      emit(state.copyWith(
          tempUnit: state.tempUnit == TempUnit.celsius
              ? TempUnit.fahrenheit
              : TempUnit.celsius));
    });
  }
}
