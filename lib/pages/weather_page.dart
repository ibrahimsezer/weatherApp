import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app_theme.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController cityController = TextEditingController();
  String cityTextField = "";
  //api key
  final _weatherService = WeatherService(apiKey: dotenv.env['API_KEY']!);

  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = "";
    if (cityTextField != "") {
      cityName = cityTextField;
    } else {
      cityName = await _weatherService.getCurrentCity();
    }
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //default condition

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

  //init state
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  //fetch weather on startup

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..", style: AppTheme.body1),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature.round()}°C', style: AppTheme.body1),

            //weather condition
            Text(_weather?.mainCondition ?? "", style: AppTheme.body1),
            SizedBox(
              width: screenSize.width * 0.6,
              child: TextField(
                controller: cityController,
                style: AppTheme.body1,
                decoration: InputDecoration(
                    hintText: "Write the city",
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            cityTextField = cityController.text;
                            cityController.text = "";
                            _fetchWeather();
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                        IconButton(
                          onPressed: () {
                            cityTextField = "";
                            cityController.text = "";
                            _fetchWeather();
                          },
                          icon: const Icon(Icons.my_location),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
