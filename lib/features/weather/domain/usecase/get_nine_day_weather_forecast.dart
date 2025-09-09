import 'package:dartz/dartz.dart';
import 'package:flutter_playground/core/failure.dart';
import 'package:flutter_playground/features/weather/data/repositories/remote_weather_forecast_repository.dart';
import 'package:flutter_playground/features/weather/domain/entities/nine_day_weather_forecast.dart';
import 'package:flutter_playground/features/weather/domain/repositories/weather_forecast_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetNineDayWeatherForecast {
  final WeatherForecastRepository repository;

  GetNineDayWeatherForecast(this.repository);

  Future<Either<Failure, NineDayWeatherForecast>> execute() async {
    return await repository.getNineDayWeatherForecast();
  }
}

final getNineDayWeatherForecastProvider = Provider<GetNineDayWeatherForecast>((ref) {
  final repository = ref.watch(weatherForecastRepositoryProvider);
  return GetNineDayWeatherForecast(repository);
});