import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/datasources/local_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalStorage _storage = LocalStorage();
  final TextEditingController _phoneController = TextEditingController();
  bool _isTurkish = true; // Default local language

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    String? savedNumber = await _storage.getEmergencyNumber();
    String? savedLang = await _storage.getLanguagePreference();
    if (savedNumber != null) _phoneController.text = savedNumber;
    if (savedLang != null) {
      setState(() {
        _isTurkish = savedLang == 'tr';
      });
    }
  }

  void _saveSettings() async {
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isTurkish ? "Lütfen geçerli bir numara girin!" : "Please enter a valid number!")),
      );
      return;
    }
    await _storage.saveEmergencyNumber(_phoneController.text.trim());
    await _storage.saveLanguagePreference(_isTurkish ? 'tr' : 'en');
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isTurkish ? "Ayarlar kaydedildi." : "Settings saved successfully.")),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(key) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isTurkish ? "SHIELD SETTINGS" : "KORUMA AYARLARI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppConstants.greyCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _isTurkish ? "SOS SOS SMS Numarası" : "SOS SMS Contact Number",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "+905XXXXXXXXX",
                        filled: true,
                        fillColor: AppConstants.primaryDark,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: AppConstants.greyCard,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                title: Text(_isTurkish ? "Uygulama Dili: Türkçe" : "App Language: English"),
                value: _isTurkish,
                activeColor: AppConstants.accentNeon,
                onChanged: (val) {
                  setState(() {
                    _isTurkish = val;
                  });
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text(_isTurkish ? "KAYDET" : "SAVE CONFIG"),
            ),
          ],
        ),
      ),
    );
  }
}
