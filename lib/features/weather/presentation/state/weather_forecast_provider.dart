import 'package:flutter_playground/features/weather/domain/entities/nine_day_weather_forecast.dart';
import 'package:flutter_playground/features/weather/domain/usecase/get_nine_day_weather_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherForecastProvider = FutureProvider<NineDayWeatherForecast?>((ref) async {
  final useCase = ref.watch(getNineDayWeatherForecastProvider);
  final either = await useCase.execute();
  return either.fold(
        (failure) => null,
        (forecast) => forecast,
  );
});