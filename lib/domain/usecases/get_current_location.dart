import 'package:dartz/dartz.dart';
import '../repositories/weather_repository.dart';
import '../../core/error/failures.dart';

class GetCurrentLocation {
  final WeatherRepository repository;

  GetCurrentLocation(this.repository);

  Future<Either<Failure, Map<String, double>>> call() async {
    return await repository.getCurrentLocation();
  }
}