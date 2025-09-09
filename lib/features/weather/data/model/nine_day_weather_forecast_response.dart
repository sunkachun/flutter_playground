import 'package:json_annotation/json_annotation.dart';

part 'nine_day_weather_forecast_response.g.dart';

@JsonSerializable()
class NineDayWeatherForecastResponse {
  final String generalSituation;
  final List<Forecast> weatherForecast;
  final String updateTime;
  final SeaTemp seaTemp;
  final List<SoilTemp> soilTemp;

  NineDayWeatherForecastResponse({
    required this.generalSituation,
    required this.weatherForecast,
    required this.updateTime,
    required this.seaTemp,
    required this.soilTemp,
  });

  factory NineDayWeatherForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$NineDayWeatherForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NineDayWeatherForecastResponseToJson(this);
}

@JsonSerializable()
class Forecast {
  final String forecastDate;
  final String week;
  final String forecastWind;
  final String forecastWeather;
  final Temperature forecastMaxtemp;
  final Temperature forecastMintemp;
  final Humidity forecastMaxrh;
  final Humidity forecastMinrh;
  @JsonKey(name: 'ForecastIcon')
  final int forecastIcon;
  final String PSR;

  Forecast({
    required this.forecastDate,
    required this.week,
    required this.forecastWind,
    required this.forecastWeather,
    required this.forecastMaxtemp,
    required this.forecastMintemp,
    required this.forecastMaxrh,
    required this.forecastMinrh,
    required this.forecastIcon,
    required this.PSR,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable()
class Temperature {
  final int value;
  final String unit;

  Temperature({required this.value, required this.unit});

  factory Temperature.fromJson(Map<String, dynamic> json) => _$TemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}

@JsonSerializable()
class Humidity {
  final int value;
  final String unit;

  Humidity({required this.value, required this.unit});

  factory Humidity.fromJson(Map<String, dynamic> json) => _$HumidityFromJson(json);

  Map<String, dynamic> toJson() => _$HumidityToJson(this);
}

@JsonSerializable()
class SeaTemp {
  final String place;
  final int value;
  final String unit;
  final String recordTime;

  SeaTemp({
    required this.place,
    required this.value,
    required this.unit,
    required this.recordTime,
  });

  factory SeaTemp.fromJson(Map<String, dynamic> json) => _$SeaTempFromJson(json);

  Map<String, dynamic> toJson() => _$SeaTempToJson(this);
}

@JsonSerializable()
class SoilTemp {
  final String place;
  final double value;
  final String unit;
  final String recordTime;
  final Depth depth;

  SoilTemp({
    required this.place,
    required this.value,
    required this.unit,
    required this.recordTime,
    required this.depth,
  });

  factory SoilTemp.fromJson(Map<String, dynamic> json) => _$SoilTempFromJson(json);

  Map<String, dynamic> toJson() => _$SoilTempToJson(this);
}

@JsonSerializable()
class Depth {
  final String unit;
  final double value;

  Depth({required this.unit, required this.value});

  factory Depth.fromJson(Map<String, dynamic> json) => _$DepthFromJson(json);

  Map<String, dynamic> toJson() => _$DepthToJson(this);
}