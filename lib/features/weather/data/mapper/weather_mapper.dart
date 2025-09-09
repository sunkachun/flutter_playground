import 'package:flutter_playground/features/weather/data/model/nine_day_weather_forecast_response.dart';
import 'package:flutter_playground/features/weather/domain/entities/nine_day_weather_forecast.dart';
import 'package:flutter_playground/features/weather/domain/entities/weather_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherMapper {
  NineDayWeatherForecast mapToNineDayWeatherForecast(NineDayWeatherForecastResponse response) {
    return NineDayWeatherForecast(
      generalSituation: response.generalSituation,
      weatherForecast: response.weatherForecast.map(mapToWeatherForecast).toList(),
      updateTime: response.updateTime,
    );
  }

  WeatherForecast mapToWeatherForecast(Forecast forecast) {
    return WeatherForecast(
      forecastDate: forecast.forecastDate,
      week: forecast.week,
      forecastWeather: forecast.forecastWeather,
      forecastMaxtemp: forecast.forecastMaxtemp.value,
      forecastMintemp: forecast.forecastMintemp.value,
      forecastIcon: mapForecastStatus(forecast.forecastIcon),
    );
  }

  WeatherStatus mapForecastStatus(int icon) {
    switch (icon) {
      case 50:
        return WeatherStatus.sunny;
      case 51:
        return WeatherStatus.sunnyPeriod;
      case 52:
        return WeatherStatus.sunnyIntervals;
      case 53:
        return WeatherStatus.sunnyPeriodsWithAFewShowers;
      case 54:
        return WeatherStatus.sunnyIntervalsWithShowers;
      case 60:
        return WeatherStatus.cloudy;
      case 61:
        return WeatherStatus.overcast;
      case 62:
        return WeatherStatus.lightRain;
      case 63:
        return WeatherStatus.rain;
      case 64:
        return WeatherStatus.heavyRain;
      case 65:
        return WeatherStatus.thunderstorms;
      case 80:
        return WeatherStatus.windy;
      case 81:
        return WeatherStatus.dry;
      case 82:
        return WeatherStatus.humid;
      case 83:
        return WeatherStatus.fog;
      case 84:
        return WeatherStatus.mist;
      case 85:
        return WeatherStatus.haze;
      case 90:
        return WeatherStatus.hot;
      case 91:
        return WeatherStatus.warm;
      case 92:
        return WeatherStatus.cool;
      case 93:
        return WeatherStatus.cold;
      default:
        return WeatherStatus.unknown;
    }
  }
}

final weatherMapperProvider = Provider<WeatherMapper>((ref) => WeatherMapper());