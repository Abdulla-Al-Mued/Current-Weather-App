import 'package:dartz/dartz.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/weather_remote_data_source.dart';
import '../datasources/location_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final LocationDataSource locationDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.locationDataSource,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(
      double latitude,
      double longitude,
      ) async {
    try {
      final weather = await remoteDataSource.getCurrentWeather(
        latitude,
        longitude,
      );
      return Right(weather);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getCurrentLocation() async {
    try {
      final location = await locationDataSource.getCurrentLocation();
      return Right(location);
    } catch (e) {
      return Left(LocationFailure(e.toString()));
    }
  }
}