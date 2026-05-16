import 'dart:convert';
import 'package:flutter/services.dart';

class GameTranslator {
  static Map<String, Map<String, String>> _translations = {};
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    
    final supportedLanguages = ['en', 'cs', 'pl', 'de', 'it', 'es', 'uk'];
    
    for (final lang in supportedLanguages) {
      try {
        final String content = await rootBundle.loadString('lib/l10n/game_$lang.arb');
        final Map<String, dynamic> json = jsonDecode(content);
        _translations[lang] = json.map((key, value) => 
          MapEntry(key, value.toString())
        );
      } catch (e) {
        // Fallback - použij angličtinu pokud jazyk není dostupný
        print('Překlad pro $lang nenalezen, používám fallback');
      }
    }
    
    _initialized = true;
  }

  static String translate(String levelId, String languageCode) {
    if (!_initialized) {
      return '...'; // Načítání
    }
    
    final langTranslations = _translations[languageCode];
    if (langTranslations != null && langTranslations.containsKey(levelId)) {
      return langTranslations[levelId]!;
    }
    
    // Fallback na angličtinu
    final enTranslations = _translations['en'];
    if (enTranslations != null && enTranslations.containsKey(levelId)) {
      return enTranslations[levelId]!;
    }
    
    // Poslední fallback - vrátí ID
    return levelId;
  }
  
  static String getCorrectMessage(String lang) {
    final messages = {
      'en': 'CORRECT!',
      'cs': 'SPÁVNĚ!',
      'pl': 'POPRAWNIE!',
      'de': 'RICHTIG!',
      'it': 'CORRETTO!',
      'es': '¡CORRECTO!',
      'uk': 'ПРАВИЛЬНО!',
    };
    return messages[lang] ?? messages['en']!;
  }
  
  static String getWrongMessage(String lang) {
    final messages = {
      'en': 'WRONG!',
      'cs': 'ŠPATNĚ!',
      'pl': 'ŹLE!',
      'de': 'FALSCH!',
      'it': 'SBAGLIATO!',
      'es': '¡INCORRECTO!',
      'uk': 'НЕПРАВИЛЬНО!',
    };
    return messages[lang] ?? messages['en']!;
  }
}
