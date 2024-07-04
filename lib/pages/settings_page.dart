import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc_listener/blocs/bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListTile(
            title: const Text("Temperature"),
            subtitle: const Text("Celsius/Fahrenheit (Default: Celsius)"),
            trailing: Switch(
                value: context.watch<TempSettingsBloc>().state.tempUnit ==
                    TempUnit.celsius,
                onChanged: (_) {
                  context.read<TempSettingsBloc>().add(ToggleTempUnitEvent());
                }),
          ),
        ));
  }
}
