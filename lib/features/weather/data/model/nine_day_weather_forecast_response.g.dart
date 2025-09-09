// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nine_day_weather_forecast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NineDayWeatherForecastResponse _$NineDayWeatherForecastResponseFromJson(
  Map<String, dynamic> json,
) => NineDayWeatherForecastResponse(
  generalSituation: json['generalSituation'] as String,
  weatherForecast: (json['weatherForecast'] as List<dynamic>)
      .map((e) => Forecast.fromJson(e as Map<String, dynamic>))
      .toList(),
  updateTime: json['updateTime'] as String,
  seaTemp: SeaTemp.fromJson(json['seaTemp'] as Map<String, dynamic>),
  soilTemp: (json['soilTemp'] as List<dynamic>)
      .map((e) => SoilTemp.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NineDayWeatherForecastResponseToJson(
  NineDayWeatherForecastResponse instance,
) => <String, dynamic>{
  'generalSituation': instance.generalSituation,
  'weatherForecast': instance.weatherForecast,
  'updateTime': instance.updateTime,
  'seaTemp': instance.seaTemp,
  'soilTemp': instance.soilTemp,
};

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
  forecastDate: json['forecastDate'] as String,
  week: json['week'] as String,
  forecastWind: json['forecastWind'] as String,
  forecastWeather: json['forecastWeather'] as String,
  forecastMaxtemp: Temperature.fromJson(
    json['forecastMaxtemp'] as Map<String, dynamic>,
  ),
  forecastMintemp: Temperature.fromJson(
    json['forecastMintemp'] as Map<String, dynamic>,
  ),
  forecastMaxrh: Humidity.fromJson(
    json['forecastMaxrh'] as Map<String, dynamic>,
  ),
  forecastMinrh: Humidity.fromJson(
    json['forecastMinrh'] as Map<String, dynamic>,
  ),
  forecastIcon: (json['ForecastIcon'] as num).toInt(),
  PSR: json['PSR'] as String,
);

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
  'forecastDate': instance.forecastDate,
  'week': instance.week,
  'forecastWind': instance.forecastWind,
  'forecastWeather': instance.forecastWeather,
  'forecastMaxtemp': instance.forecastMaxtemp,
  'forecastMintemp': instance.forecastMintemp,
  'forecastMaxrh': instance.forecastMaxrh,
  'forecastMinrh': instance.forecastMinrh,
  'ForecastIcon': instance.forecastIcon,
  'PSR': instance.PSR,
};

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
  value: (json['value'] as num).toInt(),
  unit: json['unit'] as String,
);

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{'value': instance.value, 'unit': instance.unit};

Humidity _$HumidityFromJson(Map<String, dynamic> json) => Humidity(
  value: (json['value'] as num).toInt(),
  unit: json['unit'] as String,
);

Map<String, dynamic> _$HumidityToJson(Humidity instance) => <String, dynamic>{
  'value': instance.value,
  'unit': instance.unit,
};

SeaTemp _$SeaTempFromJson(Map<String, dynamic> json) => SeaTemp(
  place: json['place'] as String,
  value: (json['value'] as num).toInt(),
  unit: json['unit'] as String,
  recordTime: json['recordTime'] as String,
);

Map<String, dynamic> _$SeaTempToJson(SeaTemp instance) => <String, dynamic>{
  'place': instance.place,
  'value': instance.value,
  'unit': instance.unit,
  'recordTime': instance.recordTime,
};

SoilTemp _$SoilTempFromJson(Map<String, dynamic> json) => SoilTemp(
  place: json['place'] as String,
  value: (json['value'] as num).toDouble(),
  unit: json['unit'] as String,
  recordTime: json['recordTime'] as String,
  depth: Depth.fromJson(json['depth'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SoilTempToJson(SoilTemp instance) => <String, dynamic>{
  'place': instance.place,
  'value': instance.value,
  'unit': instance.unit,
  'recordTime': instance.recordTime,
  'depth': instance.depth,
};

Depth _$DepthFromJson(Map<String, dynamic> json) => Depth(
  unit: json['unit'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$DepthToJson(Depth instance) => <String, dynamic>{
  'unit': instance.unit,
  'value': instance.value,
};
