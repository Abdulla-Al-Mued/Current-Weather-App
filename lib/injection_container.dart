import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/location_data_source.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_current_location.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/controllers/weather_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Controllers
  sl.registerFactory(
        () => WeatherController(
      getCurrentLocation: sl(),
      getCurrentWeather: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      locationDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
        () => WeatherRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocationDataSource>(
        () => LocationDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}