import 'package:get/get.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_current_weather.dart';

class WeatherController extends GetxController {
  final GetCurrentLocation getCurrentLocation;
  final GetCurrentWeather getCurrentWeather;

  WeatherController({
    required this.getCurrentLocation,
    required this.getCurrentWeather,
  });

  final Rx<Weather?> _weather = Rx<Weather?>(null);
  Weather? get weather => _weather.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    loadWeather();
  }

  Future<void> loadWeather() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    // Get current location
    final locationResult = await getCurrentLocation();

    locationResult.fold(
          (failure) {
        _isLoading.value = false;
        _errorMessage.value = failure.message;
      },
          (location) async {
        final latitude = location['latitude']!;
        final longitude = location['longitude']!;

        // Get weather data
        final weatherResult = await getCurrentWeather(latitude, longitude);

        weatherResult.fold(
              (failure) {
            _isLoading.value = false;
            _errorMessage.value = failure.message;
          },
              (weatherData) {
            _weather.value = weatherData;
            _isLoading.value = false;
          },
        );
      },
    );
  }

  Future<void> refreshWeather() async {
    await loadWeather();
  }
}