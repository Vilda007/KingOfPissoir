import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/game_level.dart';
import '../data/levels.dart';

class GameProvider extends ChangeNotifier {
  int _currentLevelIndex = 0;
  int _score = 0;
  int _mistakes = 0;
  int _timeRemaining = 0;
  bool _isPlaying = false;
  bool _isGameOver = false;
  bool _isVictory = false;
  List<String> _selectedPissOirs = [];
  Timer? _timer;
  List<GameLevel> _levels = [];

  // Getters
  List<GameLevel> get levels => _levels;
  GameLevel get currentLevel => _levels.isNotEmpty ? _levels[_currentLevelIndex] : _emptyLevel;
  int get score => _score;
  int get mistakes => _mistakes;
  int get timeRemaining => _timeRemaining;
  bool get isPlaying => _isPlaying;
  bool get isGameOver => _isGameOver;
  bool get isVictory => _isVictory;
  List<String> get selectedPissOirs => _selectedPissOirs;
  int get currentLevelIndex => _currentLevelIndex;
  int get totalLevels => _levels.length;
  bool get isLastLevel => _currentLevelIndex >= _levels.length - 1;

  static final GameLevel _emptyLevel = GameLevel(
    id: 0,
    name: '',
    description: '',
    pissOirs: [],
    rules: [],
  );

  void initializeLevels(String Function(String) translate) {
    _levels = GameLevels.getLevels(translate);
    notifyListeners();
  }

  void startLevel(int levelIndex) {
    _currentLevelIndex = levelIndex;
    _mistakes = 0;
    _selectedPissOirs = [];
    _isGameOver = false;
    _isVictory = false;
    _isPlaying = true;
    _timeRemaining = currentLevel.timeLimitSeconds;
    
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        notifyListeners();
      } else {
        _gameOver(false);
      }
    });
  }

  void selectPissOir(String pissOirId) {
    if (_isGameOver || !_isPlaying) return;

    final pissOir = currentLevel.pissOirs.firstWhere((p) => p.id == pissOirId);
    
    // Check if already selected
    if (_selectedPissOirs.contains(pissOirId)) {
      _selectedPissOirs.remove(pissOirId);
      notifyListeners();
      return;
    }

    _selectedPissOirs.add(pissOirId);

    // Check correctness based on rules
    final mustSelectRule = currentLevel.rules.any((r) => r.type == RuleType.mustSelect);
    final mustAvoidRule = currentLevel.rules.any((r) => r.type == RuleType.mustAvoid);

    if (mustSelectRule && pissOir.isCorrect) {
      // Correct selection!
      _score += 100 + (_timeRemaining * 2);
      _victory();
    } else if (mustAvoidRule && !pissOir.isCorrect) {
      // Correctly avoided wrong option
      _score += 100 + (_timeRemaining * 2);
      _victory();
    } else {
      // Wrong selection
      _mistakes++;
      _selectedPissOirs.remove(pissOirId);
      
      if (_mistakes >= currentLevel.maxMistakes) {
        _gameOver(false);
      } else {
        // Penalty but continue
        _score = (_score - 50).clamp(0, double.infinity).toInt();
      }
    }

    notifyListeners();
  }

  void _victory() {
    _timer?.cancel();
    _isVictory = true;
    _isGameOver = true;
    _isPlaying = false;
    notifyListeners();
  }

  void _gameOver(bool victory) {
    _timer?.cancel();
    _isGameOver = true;
    _isPlaying = false;
    _isVictory = victory;
    notifyListeners();
  }

  void nextLevel() {
    if (_currentLevelIndex < _levels.length - 1) {
      startLevel(_currentLevelIndex + 1);
    }
  }

  void restartLevel() {
    startLevel(_currentLevelIndex);
  }

  void resetGame() {
    _score = 0;
    _currentLevelIndex = 0;
    _isGameOver = false;
    _isVictory = false;
    _isPlaying = false;
    _selectedPissOirs = [];
    _timer?.cancel();
    notifyListeners();
  }

  GameResult getResult() {
    int stars = 0;
    if (_isVictory) {
      if (_mistakes == 0) stars = 3;
      else if (_mistakes == 1) stars = 2;
      else stars = 1;
    }
    
    return GameResult(
      score: _score,
      stars: stars,
      timeRemaining: _timeRemaining,
      mistakes: _mistakes,
      isPerfect: _mistakes == 0 && _isVictory,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
