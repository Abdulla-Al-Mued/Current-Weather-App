import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String condition;
  final String iconCode;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final double windSpeed;
  final String description;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.iconCode,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });

  @override
  List<Object?> get props => [
    cityName,
    temperature,
    condition,
    iconCode,
    minTemp,
    maxTemp,
    humidity,
    windSpeed,
    description,
  ];
}
