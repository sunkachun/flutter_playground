import 'package:flutter_playground/features/weather/data/model/nine_day_weather_forecast_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class WeatherForecastService {
  Future<NineDayWeatherForecastResponse> getWeatherInformation();
}

class WeatherForecastServiceImpl implements WeatherForecastService {
  final http.Client client;

  WeatherForecastServiceImpl(this.client);

  @override
  Future<NineDayWeatherForecastResponse> getWeatherInformation() async {
    final response = await client.get(
      Uri.parse('https://data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=fnd'),
    );

    if (response.statusCode == 200) {
      return NineDayWeatherForecastResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

final weatherForecastServiceProvider = Provider<WeatherForecastService>((ref) {
  return WeatherForecastServiceImpl(http.Client());
});