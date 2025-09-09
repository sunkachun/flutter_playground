import 'package:dartz/dartz.dart';
import 'package:flutter_playground/core/failure.dart';
import 'package:flutter_playground/features/weather/data/datasource/weather_forecast_service.dart';
import 'package:flutter_playground/features/weather/data/mapper/weather_mapper.dart';
import 'package:flutter_playground/features/weather/domain/entities/nine_day_weather_forecast.dart';
import 'package:flutter_playground/features/weather/domain/repositories/weather_forecast_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoteWeatherForecastRepository implements WeatherForecastRepository {
  final WeatherForecastService service;
  final WeatherMapper mapper;

  RemoteWeatherForecastRepository(this.service, this.mapper);

  @override
  Future<Either<Failure, NineDayWeatherForecast>> getNineDayWeatherForecast() async {
    try {
      final response = await service.getWeatherInformation();
      return Right(mapper.mapToNineDayWeatherForecast(response));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch weather data: $e'));
    }
  }
}

final weatherForecastRepositoryProvider = Provider<WeatherForecastRepository>((ref) {
  final service = ref.watch(weatherForecastServiceProvider);
  final mapper = ref.watch(weatherMapperProvider);
  return RemoteWeatherForecastRepository(service, mapper);
});