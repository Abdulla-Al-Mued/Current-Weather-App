import 'package:dartz/dartz.dart';
import '../entities/weather.dart';
import '../../core/error/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(
      double latitude,
      double longitude,
      );

  Future<Either<Failure, Map<String, double>>> getCurrentLocation();
}