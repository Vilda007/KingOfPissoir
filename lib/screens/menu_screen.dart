import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../l10n/app_localizations.dart';
import 'game_screen.dart';
import 'wc_game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final l10n = AppLocalizations.of(context);
    final isDark = settings.isDarkMode;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Obrázek pozadí (wall) - začíná odshora
          Positioned.fill(
            child: Image.asset(
              isDark ? 'media/wall-dark.png' : 'media/wall-light.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          
          // 2. Plynulý přechod do barvy pozadí (fade gradient)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0x00000000),
                    isDark 
                      ? const Color(0xCC000000)
                      : const Color(0xCCFFFFFF),
                    isDark 
                      ? const Color(0xFF000000)
                      : const Color(0xFFFFFFFF),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // 3. Hlavní obsah
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Nadpis
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: isDark 
                              ? Colors.black.withOpacity(0.7)
                              : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF8B4513),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark 
                                  ? Colors.black.withOpacity(0.5)
                                  : const Color(0xFF8B4513).withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.wc,
                                size: 64,
                                color: isDark ? Colors.amber.shade300 : const Color(0xFF8B4513),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'The King of',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.amber.shade300 : const Color(0xFF8B4513),
                                ),
                              ),
                              Text(
                                'Piss-oirs',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.amber.shade300 : const Color(0xFF8B4513),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Tlačítka menu
                        _MenuButton(
                          icon: Icons.play_arrow,
                          label: l10n.newGame,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const WcGameScreen()),
                            );
                          },
                          isDark: isDark,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Vypínač světel
                        _LightSwitch(
                          isOn: !isDark,
                          onToggle: () => settings.toggleLights(),
                          label: isDark ? l10n.lightsOn : l10n.lightsOff,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Jazyk
                        _MenuButton(
                          icon: Icons.language,
                          label: '${l10n.language}: ${_getLanguageName(settings.locale.languageCode)}',
                          onPressed: () => settings.toggleLanguage(),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    final names = {
      'en': 'English',
      'cs': 'Čeština',
      'pl': 'Polski',
      'de': 'Deutsch',
      'it': 'Italiano',
      'es': 'Español',
      'uk': 'Українська',
    };
    return names[code] ?? code.toUpperCase();
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isDark;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark 
          ? const Color(0xFF2a2a4a)
          : const Color(0xFF8B4513),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),
    );
  }
}

class _LightSwitch extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;
  final String label;

  const _LightSwitch({
    required this.isOn,
    required this.onToggle,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isOn 
            ? Colors.amber.withOpacity(0.3)
            : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isOn ? Colors.amber : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isOn ? Icons.lightbulb : Icons.lightbulb_outline,
                color: isOn ? Colors.amber : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isOn ? Colors.amber.shade900 : Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 50,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: isOn ? Colors.amber : Colors.grey.shade600,
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
