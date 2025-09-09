import 'package:equatable/equatable.dart';
import 'package:flutter_playground/features/weather/domain/entities/weather_status.dart';

class NineDayWeatherForecast extends Equatable {
  final String generalSituation;
  final List<WeatherForecast> weatherForecast;
  final String updateTime;

  const NineDayWeatherForecast({
    required this.generalSituation,
    required this.weatherForecast,
    required this.updateTime,
  });

  @override
  List<Object?> get props => [generalSituation, weatherForecast, updateTime];
}

class WeatherForecast extends Equatable {
  final String forecastDate;
  final String week;
  final String forecastWeather;
  final int forecastMaxtemp;
  final int forecastMintemp;
  final WeatherStatus forecastIcon;

  const WeatherForecast({
    required this.forecastDate,
    required this.week,
    required this.forecastWeather,
    required this.forecastMaxtemp,
    required this.forecastMintemp,
    required this.forecastIcon,
  });

  @override
  List<Object?> get props => [
    forecastDate,
    week,
    forecastWeather,
    forecastMaxtemp,
    forecastMintemp,
    forecastIcon,
  ];
}