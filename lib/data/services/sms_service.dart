import 'package:url_launcher/url_launcher.dart';

class SmsService {
  /// Launches native device SMS app with pre-filled emergency payload.
  Future<bool> sendEmergencySms({
    required String contactNumber, 
    required double latitude, 
    required double longitude,
    required bool isTurkish,
  }) async {
    try {
      String message = isTurkish 
        ? "ACIL DURUM: Yakinim bir kaza gecirdi! Guncel konumu: https://google.com"
        : "EMERGENCY: My contact has been involved in an accident! Current location: https://google.com";

      // Native compliant universal SMS intent URI
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: contactNumber,
        queryParameters: <String, String>{
          'body': message,
        },
      );

      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri, mode: LaunchMode.externalApplication);
        return true;
      } else {
        print("Could not launch SMS native intent");
        return false;
      }
    } catch (e) {
      print("SMS Intent Launch Failed: $e");
      return false;
    }
  }
}
