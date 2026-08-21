import 'package:geolocator/geolocator.dart';

/// Service responsible for fetching precise GPS coordinates during emergency.
class LocationService {
  
  /// Fetches current GPS coordinates of the rider.
  /// Automatically requests permissions if not granted yet.
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled on the device
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    
    if (permission == LocationPermission.deniedForever) return null;

    // Fetch location with High Accuracy for precise emergency dispatch
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 5), // Prevent getting stuck if GPS is weak
    );
  }
}
