import 'package:shared_preferences/shared_preferences.dart';

/// Service responsible for persisting emergency contacts and user settings locally.
class LocalStorage {
  static const String _keyEmergencyNumber = 'emergency_number';
  static const String _keyLanguageCode = 'language_code';

  /// Saves the emergency contact phone number to local storage.
  Future<bool> saveEmergencyNumber(String number) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_keyEmergencyNumber, number);
  }

  /// Retrieves the saved emergency contact phone number.
  Future<String?> getEmergencyNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmergencyNumber);
  }

  /// Saves user's language preference ('tr' or 'en').
  Future<bool> saveLanguagePreference(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_keyLanguageCode, languageCode);
  }

  /// Retrieves user's language preference. Defaults to device system language if null.
  Future<String?> getLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguageCode);
  }
}
