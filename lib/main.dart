import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_bloc_listener/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:open_weather_bloc_listener/blocs/theme/theme_bloc.dart';
import 'package:open_weather_bloc_listener/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc_listener/pages/home_page.dart';
import 'package:open_weather_bloc_listener/repositories/weather_repository.dart';
import 'package:open_weather_bloc_listener/services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsBloc>(
            create: (context) => TempSettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          )
        ],
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            context.read<ThemeBloc>().setTheme(state.weather.temp);
          },
          child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.appTheme == AppTheme.light
                  ? ThemeData(
                      appBarTheme: const AppBarTheme(
                          centerTitle: true,
                          backgroundColor: Color.fromARGB(209, 0, 0, 0),
                          foregroundColor: Colors.white),
                      scaffoldBackgroundColor: Colors.white,
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ThemeData.dark(),
              home: const Scaffold(
                body: HomePage(),
              ),
            );
          }),
        ),
      ),
    );
  }
}
