import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  // Ensure widget binding is initialized before listening to hardware sensors
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AsphaltKnightApp());
}

class AsphaltKnightApp extends StatelessWidget {
  const AsphaltKnightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asphalt Knight',
      debugShowCheckedModeBanner: false,
      
      // Injecting the custom protective dark rider theme
      theme: AppTheme.darkTheme,
      
      // Native Localization configurations for bilingual flexibility (TR/EN)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ],
      
      // Entry point dashboard screen
      home: const HomeScreen(),
    );
  }
}
