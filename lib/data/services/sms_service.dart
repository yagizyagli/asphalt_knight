import 'package:telephony/telephony.dart';

/// Service responsible for sending automated emergency SMS dispatches.
class SmsService {
  final Telephony _telephony = Telephony.instance;

  /// Sends background emergency SMS to the designated contact number.
  Future<bool> sendEmergencySms({
    required String contactNumber, 
    required double latitude, 
    required double longitude,
    required bool isTurkish,
  }) async {
    try {
      // Localization handling inside data service for emergency reliability
      String message = isTurkish 
        ? "ACİL DURUM: Yakınım bir motosiklet kazası geçirdi! Güncel konumu: https://google.com"
        : "EMERGENCY: My contact has been involved in a motorcycle accident! Current location: https://google.com";

      // Direct background SMS send without opening default SMS app
      await _telephony.sendSms(
        to: contactNumber,
        message: message,
      );
      return true;
    } catch (e) {
      print("SMS Dispatch Failed: $e");
      return false;
    }
  }
}
