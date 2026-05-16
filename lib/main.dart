import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'providers/game_provider.dart';
import 'l10n/app_localizations.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const KingOfPissOirsApp());
}

class KingOfPissOirsApp extends StatelessWidget {
  const KingOfPissOirsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'The King of Piss-oirs',
            debugShowCheckedModeBanner: false,
            locale: settings.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: SettingsProvider.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF8B4513),
                brightness: settings.isDarkMode ? Brightness.dark : Brightness.light,
              ),
              useMaterial3: true,
              fontFamily: 'Roboto',
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF8B4513),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              fontFamily: 'Roboto',
            ),
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MenuScreen(),
          );
        },
      ),
    );
  }
}
