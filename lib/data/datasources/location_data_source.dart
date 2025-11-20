import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationDataSource {
  Future<Map<String, double>> getCurrentLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<Map<String, double>> getCurrentLocation() async {
    // Request location permission
    final permission = await Permission.location.request();

    if (permission.isDenied || permission.isPermanentlyDenied) {
      throw Exception('Location permission denied');
    }

    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}