import '../models/game_level.dart';

// Úrovně generujeme dynamicky přes factory, abychom mohli použít překlady
class GameLevels {
  static List<GameLevel> getLevels(String Function(String) tr) => [
    GameLevel(
      id: 1,
      name: tr('beginner'),
      description: tr('beginnerDesc'),
      timeLimitSeconds: 30,
      maxMistakes: 3,
      pissOirs: [
        PissOir(id: '1', label: tr('selectUrinal'), type: PissOirType.urinal, isCorrect: true),
        PissOir(id: '2', label: 'Tree', type: PissOirType.tree),
        PissOir(id: '3', label: 'Bottle', type: PissOirType.bottle),
      ],
      rules: [
        GameRule(id: 'r1', description: tr('selectUrinal'), type: RuleType.mustSelect),
      ],
    ),
    GameLevel(
      id: 2,
      name: tr('rescue'),
      description: tr('rescueDesc'),
      timeLimitSeconds: 20,
      maxMistakes: 2,
      pissOirs: [
        PissOir(id: '1', label: 'Bush', type: PissOirType.bush),
        PissOir(id: '2', label: 'Bottle', type: PissOirType.bottle),
        PissOir(id: '3', label: 'Toilet', type: PissOirType.classic, isCorrect: true),
        PissOir(id: '4', label: 'Bidet', type: PissOirType.bidet),
      ],
      rules: [
        GameRule(id: 'r1', description: tr('rescueDesc'), type: RuleType.mustSelect),
      ],
    ),
    GameLevel(
      id: 3,
      name: tr('socialConventions'),
      description: tr('socialDesc'),
      timeLimitSeconds: 15,
      maxMistakes: 1,
      pissOirs: [
        PissOir(id: '1', label: 'Urinal', type: PissOirType.urinal),
        PissOir(id: '2', label: 'Playground', type: PissOirType.bush, isCorrect: true, hint: tr('findInappropriate')),
        PissOir(id: '3', label: 'Toilet', type: PissOirType.classic),
        PissOir(id: '4', label: 'Park bush', type: PissOirType.bush),
      ],
      rules: [
        GameRule(id: 'r1', description: tr('findInappropriate'), type: RuleType.mustAvoid),
      ],
    ),
  ];
}
