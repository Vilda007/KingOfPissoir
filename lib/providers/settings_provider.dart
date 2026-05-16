import 'package:flutter/material.dart';
import 'dart:io';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');
  
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('cs'), // Čeština
    Locale('pl'), // Polski
    Locale('de'), // Deutsch
    Locale('it'), // Italiano
    Locale('es'), // Español
    Locale('uk'), // Українська
  ];

  bool get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  SettingsProvider() {
    _detectSystemLanguage();
  }

  void _detectSystemLanguage() {
    try {
      final String systemLocale = Platform.localeName.toLowerCase();
      
      // Mapování jazyků
      final languageMap = {
        'cs': const Locale('cs'),
        'pl': const Locale('pl'),
        'de': const Locale('de'),
        'it': const Locale('it'),
        'es': const Locale('es'),
        'uk': const Locale('uk'),
      };
      
      // Najdi nejlepší shodu
      for (final entry in languageMap.entries) {
        if (systemLocale.startsWith(entry.key)) {
          _locale = entry.value;
          return;
        }
      }
      
      // Fallback na angličtinu
      _locale = const Locale('en');
    } catch (e) {
      _locale = const Locale('en');
    }
  }

  void toggleLights() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleLanguage() {
    // Najdi aktuální index a přepni na další
    final currentIndex = supportedLocales.indexOf(_locale);
    final nextIndex = (currentIndex + 1) % supportedLocales.length;
    _locale = supportedLocales[nextIndex];
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
      notifyListeners();
    }
  }
}
