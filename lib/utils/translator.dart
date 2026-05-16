import 'dart:convert';
import 'dart:io';

class GameTranslator {
  static Map<String, Map<String, String>> _translations = {};
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    
    // Načtení všech překladových souborů
    final supportedLanguages = ['en', 'cs', 'pl', 'de', 'it', 'es', 'uk'];
    
    for (final lang in supportedLanguages) {
      try {
        final file = File('lib/l10n/app_$lang.arb');
        if (await file.exists()) {
          final content = await file.readAsString();
          final Map<String, dynamic> json = jsonDecode(content);
          _translations[lang] = json.map((key, value) => 
            MapEntry(key, value.toString())
          );
        }
      } catch (e) {
        print('Chyba při načítání překladu pro $lang: $e');
      }
    }
    
    _initialized = true;
  }

  static String translate(String key, String languageCode) {
    if (!_initialized) {
      return key; // Fallback
    }
    
    final langTranslations = _translations[languageCode];
    if (langTranslations != null && langTranslations.containsKey(key)) {
      return langTranslations[key]!;
    }
    
    // Fallback na angličtinu
    final enTranslations = _translations['en'];
    if (enTranslations != null && enTranslations.containsKey(key)) {
      return enTranslations[key]!;
    }
    
    return key;
  }
  
  static String getCorrectMessage(String lang) => translate('correct', lang);
  static String getWrongMessage(String lang) => translate('wrong', lang);
  static String getNextButton(String lang) => translate('nextLevel', lang);
  static String getRetryButton(String lang) => translate('retryLevel', lang);
  static String getVictoryTitle(String lang) => translate('victoryTitle', lang);
  static String getVictorySubtitle(String lang) => translate('victorySubtitle', lang);
  static String getNewGameButton(String lang) => translate('newGame', lang);
  static String getMainMenuButton(String lang) => translate('mainMenu', lang);
}
