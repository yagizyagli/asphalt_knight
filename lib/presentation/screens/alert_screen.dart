import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/datasources/local_storage.dart';
import '../../data/services/location_service.dart';
import '../../data/services/sms_service.dart';
import 'package:geolocator/geolocator.dart';

class AlertScreen extends StatefulWidget {
  final bool isMotorMode;
  final String emergencyNumber;

  const AlertScreen({
    super.key, 
    required this.isMotorMode, 
    required this.emergencyNumber
  });

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final LocationService _locationService = LocationService();
  final SmsService _smsService = SmsService();
  final LocalStorage _storage = LocalStorage();

  int _countdown = AppConstants.countdownDurationSeconds;
  Timer? _timer;
  bool _isTurkish = true;
  bool _isDispatched = false;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _startCountdown();
  }

  void _loadLanguage() async {
    String? lang = await _storage.getLanguagePreference();
    if (lang != null) {
      setState(() {
        _isTurkish = lang == 'tr';
      });
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        _sendEmergencyAlert();
      }
    });
  }

  void _sendEmergencyAlert() async {
    if (_isDispatched) return;
    setState(() { _isDispatched = true; });

    // 1. Fetch precise GPS coordinates
    Position? currentPos = await _locationService.getCurrentLocation();
    
    // Fallback coordinates if GPS timeout occurs (to guarantee message delivery)
    double lat = currentPos?.latitude ?? 0.0;
    double log = currentPos?.longitude ?? 0.0;

    // 2. Dispatch the automated SMS via native device transceiver
    await _smsService.sendEmergencySms(
      contactNumber: widget.emergencyNumber,
      latitude: lat,
      longitude: log,
      isTurkish: _isTurkish,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(_isTurkish ? "SOS Mesajı Başarıyla Gönderildi!" : "SOS Dispatch Sent Successfully!"),
        ),
      );
      Navigator.pop(context); // Return safely to Dashboard
    }
  }

  void _cancelAlert() {
    _timer?.cancel();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.emergencyRed,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 100, color: AppConstants.textLight),
              const SizedBox(height: 24),
              Text(
                _isTurkish ? "CRASH DETECTED!" : "KAZA ALGILANDI!",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppConstants.textLight),
              ),
              const SizedBox(height: 12),
              Text(
                _isTurkish 
                  ? "Sistem otomatik olarak acil durum mesajı gönderecek." 
                  : "System will automatically dispatch an emergency distress message.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: AppConstants.textLight),
              ),
              const Spacer(),
              // Countdown Dynamic Radial UI Effect
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: CircularProgressIndicator(
                        value: _countdown / AppConstants.countdownDurationSeconds,
                        strokeWidth: 8,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppConstants.textLight),
                      ),
                    ),
                    Text(
                      "$_countdown",
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppConstants.textLight),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Big I'M OK Cancel Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.textLight,
                  foregroundColor: AppConstants.emergencyRed,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: _cancelAlert,
                child: Text(
                  _isTurkish ? "BEN İYİYİM (İPTAL ET)" : "I AM OK (CANCEL SOS)",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
