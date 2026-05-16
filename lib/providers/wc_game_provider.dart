import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/wc_level.dart';
import '../data/wc_levels.dart';
import '../utils/asset_loader.dart';
import '../utils/game_translator.dart';

class WcGameProvider extends ChangeNotifier {
  WcGameState _state = WcGameState.initial();
  Timer? _timer;
  final Random _random = Random();

  WcGameState get state => _state;
  bool get isPlaying => _state.state == GameState.playing;
  bool get isCorrect => _state.state == GameState.correct;
  bool get isWrong => _state.state == GameState.wrong;
  bool get isVictory => _state.state == GameState.victory;

  void startNewGame() {
    _timer?.cancel();
    final now = DateTime.now();
    _state = WcGameState(
      cells: [],
      currentDifficulty: 1,
      state: GameState.playing,
      levelStartTime: now,
      gameStartTime: now,
      totalTime: Duration.zero,
      levelTime: Duration.zero,
      levelResults: [],
    );
    _loadLevel(1);
    _startTimer();
    notifyListeners();
  }

  void _loadLevel(int difficulty) {
    final levels = WcLevels.getLevelsByDifficulty(difficulty);
    if (levels.isEmpty) {
      // Vítězství - nejvyšší obtížnost
      _state = _state.copyWith(state: GameState.victory);
      _timer?.cancel();
      notifyListeners();
      return;
    }

    // Náhodně vyber konfiguraci
    final config = levels[_random.nextInt(levels.length)];
    
    // Vytvoř buňky
    final cells = _parseLayout(config.layout);
    
    _state = _state.copyWith(
      cells: cells,
      currentDifficulty: difficulty,
      state: GameState.playing,
      message: null,
      explanation: null,
      selectedPosition: null,
      levelStartTime: DateTime.now(),
    );
    
    notifyListeners();
  }

  List<WcCell> _parseLayout(String layout, {bool darkMode = false}) {
    final cells = <WcCell>[];
    
    // Reset cache pro každou úroveň - aby se náhodně vybraly nové obrázky
    AssetLoader.clearCache();
    
    for (int i = 0; i < layout.length; i++) {
      final char = layout[i];
      WcCellType type;
      String? imageAsset;
      
      switch (char) {
        case 'D':
          type = WcCellType.door;
          imageAsset = _getRandomDoorImage();
          break;
        case 'W':
          type = WcCellType.wall;
          imageAsset = _getRandomWallImage();
          break;
        case 'P':
          type = WcCellType.free;
          // Každý pissoir má svůj náhodný obrázek
          imageAsset = _getRandomPissoirImage(darkMode: darkMode);
          break;
        case 'O':
          type = WcCellType.occupied;
          // Každý muž má svůj náhodný obrázek
          imageAsset = _getRandomManImage();
          break;
        case 'X':
          type = WcCellType.correct;
          // Správná odpověď má také náhodný pissoir
          imageAsset = _getRandomPissoirImage(darkMode: darkMode);
          break;
        default:
          type = WcCellType.free;
          imageAsset = _getRandomPissoirImage(darkMode: darkMode);
      }
      
      cells.add(WcCell(
        type: type,
        position: i,
        imageAsset: imageAsset,
      ));
    }
    
    return cells;
  }

  String _getRandomDoorImage() {
    return AssetLoader.getRandomDoor();
  }

  String _getRandomWallImage() {
    return AssetLoader.getRandomWall();
  }

  String _getRandomPissoirImage({bool darkMode = false}) {
    return AssetLoader.getRandomPissoir(darkMode: darkMode);
  }

  String _getRandomManImage() {
    return AssetLoader.getRandomMan();
  }

  // Aktuální jazyk pro překlady
  String _currentLanguage = 'cs';
  
  String get currentLanguage => _currentLanguage;
  
  void setLanguage(String language) {
    _currentLanguage = language;
  }
  
  void onCellTap(int position) {
    if (!isPlaying) return;
    
    final cell = _state.cells[position];
    
    // Kontrola kliknutí na interaktivní pole (P nebo X)
    if (cell.type != WcCellType.free && cell.type != WcCellType.correct) {
      return; // Dveře, zeď, obsazeno - neinteraktivní
    }
    
    final isCorrect = cell.type == WcCellType.correct;
    final now = DateTime.now();
    final levelTime = now.difference(_state.levelStartTime);
    final totalTime = now.difference(_state.gameStartTime);
    
    if (isCorrect) {
      // Správná odpověď
      final levels = WcLevels.getLevelsByDifficulty(_state.currentDifficulty);
      final config = levels.firstWhere((l) => l.layout == _getLayoutFromCells());
      
      // Přelož popis podle jazyka
      final translatedDescription = GameTranslator.translate(config.id, _currentLanguage);
      
      _state = _state.copyWith(
        state: GameState.correct,
        message: GameTranslator.getCorrectMessage(_currentLanguage),
        explanation: translatedDescription,
        selectedPosition: position,
        levelTime: levelTime,
        totalTime: totalTime,
        levelResults: [
          ..._state.levelResults,
          LevelResult(
            difficulty: _state.currentDifficulty,
            time: levelTime,
            success: true,
          ),
        ],
      );
    } else {
      // Špatná odpověď
      final levels = WcLevels.getLevelsByDifficulty(_state.currentDifficulty);
      final config = levels.firstWhere((l) => l.layout == _getLayoutFromCells());
      
      // Přelož popis podle jazyka
      final translatedDescription = GameTranslator.translate(config.id, _currentLanguage);
      
      _state = _state.copyWith(
        state: GameState.wrong,
        message: GameTranslator.getWrongMessage(_currentLanguage),
        explanation: translatedDescription,
        selectedPosition: position,
        levelTime: levelTime,
        totalTime: totalTime,
      );
    }
    
    notifyListeners();
  }

  String _getLayoutFromCells() {
    return _state.cells.map((c) {
      switch (c.type) {
        case WcCellType.door: return 'D';
        case WcCellType.wall: return 'W';
        case WcCellType.free: return 'P';
        case WcCellType.occupied: return 'O';
        case WcCellType.correct: return 'X';
      }
    }).join();
  }

  void nextLevel() {
    if (!isCorrect) return;
    
    final nextDifficulty = WcLevels.getNextDifficulty(_state.currentDifficulty);
    
    // Kontrola vítězství
    if (nextDifficulty == -1) {
      _state = _state.copyWith(
        state: GameState.victory,
        totalTime: DateTime.now().difference(_state.gameStartTime),
      );
      _timer?.cancel();
      notifyListeners();
      return;
    }
    
    _loadLevel(nextDifficulty);
  }

  void retryLevel() {
    if (!isWrong) return;
    _loadLevel(_state.currentDifficulty);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      _state = _state.copyWith(
        totalTime: now.difference(_state.gameStartTime),
        levelTime: now.difference(_state.levelStartTime),
      );
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
