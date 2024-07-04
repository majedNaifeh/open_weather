import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc_listener/blocs/bloc.dart';
import 'package:open_weather_bloc_listener/constants/constants.dart';
import 'package:open_weather_bloc_listener/pages/search_page.dart';
import 'package:open_weather_bloc_listener/pages/settings_page.dart';
import 'package:open_weather_bloc_listener/widgets/error_dialog.dart';

import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  @override
  void initState() {
    super.initState();
    // _fetchWeather();
  }

  // _fetchWeather() {
  //   context.read<WeatherBloc>().fetchWeather('london');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
              print(_city);
              if (_city != null) {
                context
                    .read<WeatherBloc>()
                    .add(FetchWeatherEvent(city: _city!));
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: _showWeather(),
    );
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/images/loading.gif",
      image: "http://$kIconHost/img/wn/$icon@4x.png",
      width: 96,
      height: 96,
    );
  }

  Widget formatText(String description) {
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsBloc>();
    if (tempUnit.state.tempUnit == TempUnit.celsius) {
      return "${temperature.toStringAsFixed(2)}℃";
    }
    return "${((temperature * 9 / 5) + 32).toStringAsFixed(2)}℉";
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == WeatherStatus.initial) {
          return const Center(child: Text("Please search for a city"));
        }
        if (state.status == WeatherStatus.error && state.weather.name == "") {
          return const Center(child: Text("Enter a City name"));
        }
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdated)
                      .format(context),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  state.weather.country,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemperature(state.weather.temp),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      showTemperature(state.weather.tempMax),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      showTemperature(state.weather.tempMin),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                showIcon(state.weather.icon),
                Expanded(flex: 2, child: formatText(state.weather.description)),
                const Spacer(),
              ],
            )
          ],
        );
      },
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
    );
  }
}
