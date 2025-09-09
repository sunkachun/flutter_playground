import 'package:flutter/material.dart';
import 'package:flutter_playground/features/weather/domain/entities/nine_day_weather_forecast.dart';
import 'package:flutter_playground/features/weather/domain/entities/weather_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/weather_forecast_provider.dart';

class WeatherForecastPage extends ConsumerWidget {
  const WeatherForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherForecastProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: weatherState.when(
        data: (forecast) => WeatherForecastContent(forecast: forecast),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class WeatherForecastContent extends StatelessWidget {
  final NineDayWeatherForecast? forecast;

  const WeatherForecastContent({Key? key, this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (forecast == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          forecast!.generalSituation,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Updated: ${forecast!.updateTime}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        ...forecast!.weatherForecast.map((weatherItem) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: WeatherForecastItem(weatherItem: weatherItem),
        )),
      ],
    );
  }
}

class WeatherForecastItem extends StatelessWidget {
  final WeatherForecast weatherItem;

  const WeatherForecastItem({Key? key, required this.weatherItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                _getIconPath(weatherItem.forecastIcon),
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      weatherItem.forecastDate,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      weatherItem.forecastWeather,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Max: ${weatherItem.forecastMaxtemp}°C',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Min: ${weatherItem.forecastMintemp}°C',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getIconPath(WeatherStatus status) {
    switch (status) {
      case WeatherStatus.sunny:
        return 'icons/ic_weather_sunny.png';
      case WeatherStatus.cloudy:
        return 'icons/ic_weather_cloudly.png';
      case WeatherStatus.thunderstorms:
        return 'icons/ic_weather_thunderstorm.png';
      case WeatherStatus.windy:
        return 'icons/ic_weather_storm.png';
      case WeatherStatus.lightRain:
      case WeatherStatus.rain:
      case WeatherStatus.heavyRain:
        return 'icons/ic_weather_rain.png';
      case WeatherStatus.fog:
        return 'icons/ic_weather_fog.png';
      case WeatherStatus.cold:
      case WeatherStatus.cool:
        return 'icons/ic_weather_cold.png';
      default:
        return 'icons/ic_weather_sunny.png';
    }
  }
}