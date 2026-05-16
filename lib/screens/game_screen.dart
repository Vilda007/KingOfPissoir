import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
import '../l10n/app_localizations.dart';
import '../models/game_level.dart';
import '../widgets/piss_oir_button.dart';
import '../widgets/game_timer.dart';
import '../widgets/score_display.dart';
import '../widgets/level_indicator.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF5F5DC), // Beige
                Color(0xFFE8DCC8), // Darker beige
              ],
            ),
          ),
          child: SafeArea(
            child: Consumer<GameProvider>(
              builder: (context, game, child) {
                if (!game.isPlaying && !game.isGameOver) {
                  return _buildMainMenu(context, game);
                }
                if (game.isGameOver) {
                  return _buildGameOver(context, game);
                }
                return _buildGameLevel(context, game);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainMenu(BuildContext context, GameProvider game) {
    // Toto se již nepoužívá - hlavní menu je v menu_screen.dart
    // Ale necháme pro případ přímého vstupu
    final l10n = AppLocalizations.of(context);
    final settings = context.read<SettingsProvider>();
    final isDark = settings.isDarkMode;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wc,
            size: 120,
            color: isDark ? Colors.amber.shade300 : const Color(0xFF8B4513),
          ),
          const SizedBox(height: 24),
          Text(
            'The King of',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: isDark ? Colors.amber.shade300 : const Color(0xFF8B4513),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Piss-oirs',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: isDark ? Colors.amber.shade300 : const Color(0xFF8B4513),
              fontWeight: FontWeight.bold,
              fontSize: 56,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '👑 ${l10n.appTitle} 👑',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: () => game.startLevel(0),
            icon: const Icon(Icons.play_arrow, size: 32),
            label: Text(
              l10n.newGame.toUpperCase(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark 
                ? const Color(0xFF2a2a4a)
                : const Color(0xFF8B4513),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (game.score > 0)
            Text(
              '${l10n.score}: ${game.score}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.mainMenu),
          ),
        ],
      ),
    );
  }

  Widget _buildGameLevel(BuildContext context, GameProvider game) {
    final level = game.currentLevel;
    
    return Column(
      children: [
        // Top bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LevelIndicator(
                current: game.currentLevelIndex + 1,
                total: game.totalLevels,
              ),
              GameTimer(seconds: game.timeRemaining),
              ScoreDisplay(score: game.score),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Level info
        Text(
          level.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8B4513),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          level.description,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 32),
        
        // Rules
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8DC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF8B4513), width: 2),
          ),
          child: Column(
            children: level.rules.map((rule) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    rule.type == RuleType.mustAvoid 
                      ? Icons.warning 
                      : Icons.check_circle,
                    color: rule.type == RuleType.mustAvoid 
                      ? Colors.orange 
                      : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      rule.description,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Piss-oirs grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: level.pissOirs.length,
            itemBuilder: (context, index) {
              final pissOir = level.pissOirs[index];
              final isSelected = game.selectedPissOirs.contains(pissOir.id);
              
              return PissOirButton(
                pissOir: pissOir,
                isSelected: isSelected,
                onTap: () => game.selectPissOir(pissOir.id),
              );
            },
          ),
        ),
        
        // Mistakes indicator
        if (game.mistakes > 0)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                level.maxMistakes,
                (index) => Icon(
                  index < game.mistakes ? Icons.error : Icons.error_outline,
                  color: index < game.mistakes ? Colors.red : Colors.grey,
                  size: 32,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGameOver(BuildContext context, GameProvider game) {
    final result = game.getResult();
    final l10n = AppLocalizations.of(context);
    
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              game.isVictory ? Icons.emoji_events : Icons.sentiment_dissatisfied,
              size: 100,
              color: game.isVictory ? Colors.amber : Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              game.isVictory ? l10n.victory : l10n.gameOver,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: game.isVictory ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            
            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Icon(
                  index < result.stars ? Icons.star : Icons.star_border,
                  size: 48,
                  color: index < result.stars ? Colors.amber : Colors.grey,
                );
              }),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              '${l10n.score}: ${result.score}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (result.isPerfect)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🏆 ${l10n.perfect} 🏆',
                  style: const TextStyle(
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
                  onPressed: () => game.restartLevel(),
                  icon: const Icon(Icons.replay),
                  label: Text(l10n.retry),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                if (game.isVictory && !game.isLastLevel)
                  ElevatedButton.icon(
                    onPressed: () => game.nextLevel(),
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(l10n.next),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                game.resetGame();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.home),
              label: Text(l10n.mainMenu),
            ),
          ],
        ),
      ),
    );
  }
}
