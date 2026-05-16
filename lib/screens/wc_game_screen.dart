import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wc_game_provider.dart';
import '../providers/settings_provider.dart';
import '../models/wc_level.dart';
import '../utils/game_translator.dart';
import '../l10n/app_localizations.dart';
import 'menu_screen.dart';

class WcGameScreen extends StatelessWidget {
  const WcGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsProvider>();
    
    return FutureBuilder(
      future: GameTranslator.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        return ChangeNotifierProvider(
          create: (_) {
            final provider = WcGameProvider();
            provider.setLanguage(settings.locale.languageCode);
            provider.startNewGame();
            return provider;
          },
          child: const _WcGameView(),
        );
      },
    );
  }
}

class _WcGameView extends StatelessWidget {
  const _WcGameView();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<WcGameProvider>();
    final settings = context.watch<SettingsProvider>();
    final l10n = AppLocalizations.of(context);
    final isDark = settings.isDarkMode;
    
    // Aktualizace jazyka při změně
    if (game.currentLanguage != settings.locale.languageCode) {
      game.setLanguage(settings.locale.languageCode);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: isDark ? Colors.black : Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // 1. HEADER
              _buildHeader(context, game, l10n, isDark),
              
              // 2. WC Hrací plocha
              Expanded(
                flex: 3,
                child: _buildWcArea(context, game, isDark),
              ),
              
              // 3. EXPLANATION
              Expanded(
                flex: 2,
                child: _buildExplanation(context, game, l10n, isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WcGameProvider game, AppLocalizations l10n, bool isDark) {
    final state = game.state;
    
    String? message;
    Color? messageColor;
    
    if (game.isCorrect) {
      message = l10n.correct;
      messageColor = Colors.green;
    } else if (game.isWrong) {
      message = l10n.wrong;
      messageColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B4513),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${l10n.level} ${state.currentDifficulty}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              _TimeDisplay(
                label: l10n.levelTime,
                time: state.levelTime,
                isDark: isDark,
              ),
            ],
          ),
          
          const SizedBox(height: 4),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeDisplay(
                label: l10n.gameTime,
                time: state.totalTime,
                isDark: isDark,
                isSmall: true,
              ),
            ],
          ),
          
          if (message != null)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: messageColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWcArea(BuildContext context, WcGameProvider game, bool isDark) {
    final cells = game.state.cells;
    if (cells.isEmpty) return const Center(child: CircularProgressIndicator());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: [
          // Pozice 0 - Dveře nebo Zeď
          Expanded(
            flex: 10,
            child: _buildEdgeCell(cells[0], isDark),
          ),
          
          // 5 interaktivních polí (16% každé = 80%)
          ...cells.sublist(1, 6).map((cell) {
            return Expanded(
              flex: 16,
              child: _buildInteractiveCell(context, game, cell, isDark),
            );
          }).toList(),
          
          // Pozice 6 - Zeď nebo Dveře
          Expanded(
            flex: 10,
            child: _buildEdgeCell(cells[6], isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildEdgeCell(WcCell cell, bool isDark) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          
          return Image.asset(
            cell.imageAsset ?? '',
            width: width,  // Dveře na celou šířku buňky
            height: height,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
              _buildFallbackIcon(cell.type, width),
          );
        },
      ),
    );
  }

  Widget _buildInteractiveCell(BuildContext context, WcGameProvider game, WcCell cell, bool isDark) {
    final isClickable = cell.type == WcCellType.free || cell.type == WcCellType.correct;
    final isSelected = game.state.selectedPosition == cell.position;
    
    // Velikosti obrázků podle typu
    double imageScale;
    if (cell.type == WcCellType.free || cell.type == WcCellType.correct) {
      imageScale = 0.75; // Pissoir menší (50% z původní velikosti 1.5)
    } else if (cell.type == WcCellType.occupied) {
      imageScale = 1.5; // Muž o 50% větší
    } else {
      imageScale = 1.0;
    }

    return GestureDetector(
      onTap: isClickable && game.isPlaying
        ? () => game.onCellTap(cell.position)
        : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.maxWidth;
            
            return Stack(
              alignment: Alignment.center,
              children: [
                // Obrázek nebo fallback ikona
                if (cell.imageAsset != null && cell.imageAsset!.isNotEmpty)
                  Image.asset(
                    cell.imageAsset!,
                    width: size * imageScale,
                    height: size * imageScale,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                      _buildFallbackIcon(cell.type, size * imageScale),
                  )
                else
                  _buildFallbackIcon(cell.type, size * imageScale),
                
                // Indikátor správnosti (pouze po výběru)
                if (isSelected && !game.isPlaying)
                  Container(
                    width: size * 0.8,
                    height: size * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: game.isCorrect ? Colors.green : Colors.red,
                        width: 4,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(WcCellType type, double size) {
    IconData icon;
    switch (type) {
      case WcCellType.free:
      case WcCellType.correct:
        icon = Icons.water_drop_outlined;
        break;
      case WcCellType.occupied:
        icon = Icons.person;
        break;
      default:
        icon = Icons.help_outline;
    }
    
    return Icon(icon, size: size * 0.5);
  }

  Widget _buildExplanation(BuildContext context, WcGameProvider game, AppLocalizations l10n, bool isDark) {
    final state = game.state;
    
    if (game.isPlaying) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            l10n.selectPissoir,
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    
    if (game.isVictory) {
      return _buildVictoryScreen(context, game, l10n, isDark);
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                state.explanation ?? '',
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          ElevatedButton.icon(
            onPressed: game.isCorrect 
              ? () => game.nextLevel()
              : () => game.retryLevel(),
            icon: Icon(game.isCorrect ? Icons.arrow_forward : Icons.replay),
            label: Text(
              game.isCorrect ? l10n.nextLevel : l10n.retryLevel,
              style: const TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: game.isCorrect ? Colors.green : Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVictoryScreen(BuildContext context, WcGameProvider game, AppLocalizations l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
              );
            },
          ),
          const SizedBox(height: 24),
          
          Text(
            l10n.victoryTitle,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.amber : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            l10n.victorySubtitle,
            style: TextStyle(
              fontSize: 20,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: Text(
              '${l10n.totalTime}: ${_formatTime(game.state.totalTime)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => game.startNewGame(),
                icon: const Icon(Icons.play_arrow),
                label: Text(l10n.newGame),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MenuScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                label: Text(l10n.mainMenu),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class _TimeDisplay extends StatelessWidget {
  final String label;
  final Duration time;
  final bool isDark;
  final bool isSmall;

  const _TimeDisplay({
    required this.label,
    required this.time,
    required this.isDark,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.timer,
          size: isSmall ? 14 : 18,
          color: isDark ? Colors.white60 : Colors.black54,
        ),
        const SizedBox(width: 4),
        Text(
          '$label: ${_formatTime(time)}',
          style: TextStyle(
            fontSize: isSmall ? 12 : 16,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
