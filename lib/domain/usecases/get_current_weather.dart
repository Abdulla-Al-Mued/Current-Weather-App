
import 'package:dartz/dartz.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';
import '../../core/error/failures.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> call(
      double latitude,
      double longitude,
      ) async {
    return await repository.getCurrentWeather(latitude, longitude);
  }
}