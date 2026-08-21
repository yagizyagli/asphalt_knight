import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

/// Service responsible for monitoring device accelerometer sensors
/// and detecting high-impact crashes.
class SensorService {
  // 8.0G threshold. Standard potholes are usually under 3-4G. 
  // Motorcycle crashes produce massive instantaneous G-force spikes.
  static const double _crashThresholdG = 8.0; 
  static const double _gravityConstant = 9.80665;

  StreamSubscription<UserAccelerometerEvent>? _accelerometerSubscription;
  bool _isMonitoring = false;

  /// Starts listening to accelerometer data.
  /// Triggers [onCrashDetected] callback when G-force exceeds the threshold.
  void startMonitoring({required Function() onCrashDetected}) {
    if (_isMonitoring) return;
    _isMonitoring = true;

    _accelerometerSubscription = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      // Calculate total instantaneous acceleration vector length (Magnitude)
      // Formula: sqrt(x² + y² + z²)
      double totalAcceleration = double.parse(
        (event.x * event.x + event.y * event.y + event.z * event.z).toString()
      );
      
      // Convert raw acceleration to G-force
      double gForce = totalAcceleration / _gravityConstant;

      // If the impact is larger than our threshold, trigger emergency
      if (gForce >= _crashThresholdG) {
        stopMonitoring(); // Pause monitoring to prevent multiple triggers
        onCrashDetected();
      }
    });
  }

  /// Stops listening to the sensors to save battery when ride ends.
  void stopMonitoring() {
    _accelerometerSubscription?.cancel();
    _isMonitoring = false;
  }
}
