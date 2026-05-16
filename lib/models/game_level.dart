class GameLevel {
  final int id;
  final String name;
  final String description;
  final List<PissOir> pissOirs;
  final List<GameRule> rules;
  final int timeLimitSeconds;
  final int maxMistakes;

  const GameLevel({
    required this.id,
    required this.name,
    required this.description,
    required this.pissOirs,
    required this.rules,
    this.timeLimitSeconds = 60,
    this.maxMistakes = 3,
  });
}

class PissOir {
  final String id;
  final String label;
  final PissOirType type;
  final bool isCorrect;
  final String? hint;

  const PissOir({
    required this.id,
    required this.label,
    required this.type,
    this.isCorrect = false,
    this.hint,
  });
}

enum PissOirType {
  classic,
  urinal,
  squat,
  bidet,
  tree,
  bottle,
  bush,
}

class GameRule {
  final String id;
  final String description;
  final RuleType type;

  const GameRule({
    required this.id,
    required this.description,
    required this.type,
  });
}

enum RuleType {
  mustSelect,
  mustAvoid,
  timing,
  sequence,
}

class GameResult {
  final int score;
  final int stars;
  final int timeRemaining;
  final int mistakes;
  final bool isPerfect;

  const GameResult({
    required this.score,
    required this.stars,
    required this.timeRemaining,
    required this.mistakes,
    this.isPerfect = false,
  });
}
