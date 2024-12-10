import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whater/models/weather_model.dart';
import 'package:whater/services/weather_sevice.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherSevice('7a539e88eb4e2e223f80d8f9259f7fc9');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 204, 204),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading city...",
              style: const TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
                fontSize: 25,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1.5),
                    blurRadius: 7.0,
                    color: Color.fromARGB(79, 0, 0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            const SizedBox(
              height: 80,
            ),
            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1.5),
                    blurRadius: 7.0,
                    color: Color.fromARGB(79, 0, 0, 0),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Icon(Icons.water_drop_outlined, color: Colors.white),
                    Text(' ${_weather?.humidity.round()}%',
                      style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        color: Colors.white,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1.5),
                            blurRadius: 7.0,
                            color: Color.fromARGB(79, 0, 0, 0),
                          ),
                        ],
                      ),
                    )
                  ]),
                  Row(children: [
                    const Icon(
                      Icons.dew_point,
                      color: Colors.white,
                    ),
                    Text(
                      ' ${_weather?.feels_like.round()}°C',
                      style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        color: Colors.white,
                        fontSize: 15,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1.5),
                            blurRadius: 7.0,
                            color: Color.fromARGB(79, 0, 0, 0),
                          ),
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: const TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
                fontSize: 15,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1.5),
                    blurRadius: 7.0,
                    color: Color.fromARGB(79, 0, 0, 0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
