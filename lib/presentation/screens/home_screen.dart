import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/datasources/local_storage.dart';
import '../../data/services/sensor_service.dart';
import 'alert_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SensorService _sensorService = SensorService();
  final LocalStorage _storage = LocalStorage();
  
  bool _isRideActive = false;
  bool _isMotorMode = true; // true = Motor, false = Car
  bool _isTurkish = true;
  String? _emergencyNumber;

  @override
  void initState() {
    super.initState();
    _checkConfiguration();
  }

  void _checkConfiguration() async {
    _emergencyNumber = await _storage.getEmergencyNumber();
    String? lang = await _storage.getLanguagePreference();
    if (lang != null) {
      setState(() {
        _isTurkish = lang == 'tr';
      });
    }
  }

  void _toggleRide() {
    if (_emergencyNumber == null || _emergencyNumber!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isTurkish ? "Önce ayarlardan acil durum numarası ekleyin!" : "Please add an emergency number in settings first!")),
      );
      return;
    }

    setState(() {
      _isRideActive = !_isRideActive;
    });

    if (_isRideActive) {
      _sensorService.startMonitoring(
        onCrashDetected: () {
          setState(() { _isRideActive = false; });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlertScreen(isMotorMode: _isMotorMode, emergencyNumber: _emergencyNumber!),
            ),
          );
        },
      );
    } else {
      _sensorService.stopMonitoring();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color activeModeColor = _isMotorMode ? AppConstants.accentNeon : AppConstants.accentCarBlue;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ASPHALT KNIGHT"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              if (result == true) _checkConfiguration();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mode Selector (Motorcycle / Car)
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Text(_isTurkish ? "🏍️ ŞÖVALYE (Motor)" : "🏍️ KNIGHT (Motor)"),
                    selected: _isMotorMode,
                    selectedColor: AppConstants.accentNeon.withOpacity(0.3),
                    onSelected: _isRideActive ? null : (val) => setState(() => _isMotorMode = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: Text(_isTurkish ? "🚗 SAVAŞ ARABASI" : "🚗 CHARIOT (Car)"),
                    selected: !_isMotorMode,
                    selectedColor: AppConstants.accentCarBlue.withOpacity(0.3),
                    onSelected: _isRideActive ? null : (val) => setState(() => _isMotorMode = false),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Massive Circle Action Button
            Center(
              child: GestureDetector(
                onTap: _toggleRide,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isRideActive ? AppConstants.emergencyRed : AppConstants.greyCard,
                    border: Border.all(
                      color: _isRideActive ? AppConstants.emergencyRed : activeModeColor,
                      width: 6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isRideActive ? AppConstants.emergencyRed.withOpacity(0.4) : activeModeColor.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isRideActive ? Icons.shield : Icons.play_arrow,
                          size: 56,
                          color: _isRideActive ? AppConstants.textLight : activeModeColor,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isRideActive 
                              ? (_isTurkish ? "KORUMA AKTİF" : "SHIELD ACTIVE")
                              : (_isTurkish ? "SÜRÜŞÜ BAŞLAT" : "START RIDE"),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              _isRideActive 
                  ? (_isTurkish ? "Sensörler arka planda kazaları dinliyor..." : "Sensors are tracking impacts in background...")
                  : (_isTurkish ? "Yola çıkmadan önce modu seçip butona basın." : "Select mode and trigger shield before riding."),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppConstants.textLight.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
