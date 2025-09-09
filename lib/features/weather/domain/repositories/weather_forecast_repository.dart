import 'package:dartz/dartz.dart';
import 'package:flutter_playground/core/failure.dart';
import 'package:flutter_playground/features/weather/domain/entities/nine_day_weather_forecast.dart';

abstract class WeatherForecastRepository {
  Future<Either<Failure, NineDayWeatherForecast>> getNineDayWeatherForecast();
}