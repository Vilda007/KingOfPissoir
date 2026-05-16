import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<bool> load() async {
    try {
      String jsonString = await rootBundle.loadString('lib/l10n/app_${locale.languageCode}.arb');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      return true;
    } catch (e) {
      // Fallback to English
      String jsonString = await rootBundle.loadString('lib/l10n/app_en.arb');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      return true;
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  String get appTitle => translate('appTitle');
  String get newGame => translate('newGame');
  String get lightsOn => translate('lightsOn');
  String get lightsOff => translate('lightsOff');
  String get language => translate('language');
  String get selectLanguage => translate('selectLanguage');
  String get level => translate('level');
  String get score => translate('score');
  String get time => translate('time');
  String get victory => translate('victory');
  String get gameOver => translate('gameOver');
  String get perfect => translate('perfect');
  String get retry => translate('retry');
  String get next => translate('next');
  String get mainMenu => translate('mainMenu');
  String get beginner => translate('beginner');
  String get rescue => translate('rescue');
  String get socialConventions => translate('socialConventions');
  String get beginnerDesc => translate('beginnerDesc');
  String get rescueDesc => translate('rescueDesc');
  String get socialDesc => translate('socialDesc');
  String get selectUrinal => translate('selectUrinal');
  String get findInappropriate => translate('findInappropriate');
  String get stars => translate('stars');
  String get mistakes => translate('mistakes');
  String get levelComplete => translate('levelComplete');
  String get correct => translate('correct');
  String get wrong => translate('wrong');
  String get nextLevel => translate('nextLevel');
  String get retryLevel => translate('retryLevel');
  String get victoryTitle => translate('victoryTitle');
  String get victorySubtitle => translate('victorySubtitle');
  String get totalTime => translate('totalTime');
  String get selectPissoir => translate('selectPissoir');
  String get explanation => translate('explanation');
  String get continueGame => translate('continueGame');
  String get restartGame => translate('restartGame');
  String get gameTime => translate('gameTime');
  String get levelTime => translate('levelTime');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'cs', 'pl', 'de', 'it', 'es', 'uk'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
