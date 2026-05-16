export '../data/wc_levels.dart' show WcLevelConfig;

enum WcCellType {
  door,      // D - Dveře
  wall,      // W - Zeď
  free,      // P - Volný pissoir
  occupied,  // O - Obsazený pissoir
  correct,   // X - Správná odpověď (volný pissoir)
}

class WcCell {
  final WcCellType type;
  final int position; // 0-6
  final String? imageAsset; // Cesta k obrázku

  WcCell({
    required this.type,
    required this.position,
    this.imageAsset,
  });
}

enum GameState {
  playing,   // Hraje se
  correct,   // Správná odpověď
  wrong,     // Špatná odpověď
  victory,   // Vyhrál
}

class WcGameState {
  final List<WcCell> cells;
  final int currentDifficulty;
  final GameState state;
  final String? message; // SPÁVNĚ / ŠPATNĚ
  final String? explanation; // Vysvětlení
  final int? selectedPosition; // Pozice kliknutí
  final DateTime levelStartTime;
  final DateTime gameStartTime;
  final Duration totalTime;
  final Duration levelTime;
  final List<LevelResult> levelResults;

  WcGameState({
    required this.cells,
    required this.currentDifficulty,
    required this.state,
    this.message,
    this.explanation,
    this.selectedPosition,
    required this.levelStartTime,
    required this.gameStartTime,
    required this.totalTime,
    required this.levelTime,
    required this.levelResults,
  });

  WcGameState.initial()
      : cells = [],
        currentDifficulty = 1,
        state = GameState.playing,
        message = null,
        explanation = null,
        selectedPosition = null,
        levelStartTime = DateTime.now(),
        gameStartTime = DateTime.now(),
        totalTime = Duration.zero,
        levelTime = Duration.zero,
        levelResults = [];

  WcGameState copyWith({
    List<WcCell>? cells,
    int? currentDifficulty,
    GameState? state,
    String? message,
    String? explanation,
    int? selectedPosition,
    DateTime? levelStartTime,
    DateTime? gameStartTime,
    Duration? totalTime,
    Duration? levelTime,
    List<LevelResult>? levelResults,
  }) {
    return WcGameState(
      cells: cells ?? this.cells,
      currentDifficulty: currentDifficulty ?? this.currentDifficulty,
      state: state ?? this.state,
      message: message ?? this.message,
      explanation: explanation ?? this.explanation,
      selectedPosition: selectedPosition ?? this.selectedPosition,
      levelStartTime: levelStartTime ?? this.levelStartTime,
      gameStartTime: gameStartTime ?? this.gameStartTime,
      totalTime: totalTime ?? this.totalTime,
      levelTime: levelTime ?? this.levelTime,
      levelResults: levelResults ?? this.levelResults,
    );
  }
}

class LevelResult {
  final int difficulty;
  final Duration time;
  final bool success;

  LevelResult({
    required this.difficulty,
    required this.time,
    required this.success,
  });
}
