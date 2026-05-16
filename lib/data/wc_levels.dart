import '../models/wc_level.dart';

export '../models/wc_level.dart' show WcLevelConfig;

class WcLevels {
  // Formát: XXXXXXX - 7 pozic 
  // Pozice 0 = D nebo W (dveře/zeď)
  // Pozice 6 = D nebo W (dveře/zeď) - opačná hodnota než na pozici 0
  // Pozice 1-5 = P, O, X (interaktivní pole)
  
  static final Map<int, List<WcLevelConfig>> _levels = {
    1: [
      WcLevelConfig(
        id: 'DPPPPXW-1A',
        difficulty: 1,
        layout: 'DPPPPXW',
        description: 'Základní instinkt. Pravidlo číslo jedna: co nejdál od dveří. Nechceš, aby tě hned při vstupu někdo trefil klikou, nebo abys prvním příchozím dělal uvítací výbor.',
      ),
      WcLevelConfig(
        id: 'WXPPPPD-1B',
        difficulty: 1,
        layout: 'WXPPPPD',
        description: 'Zrcadlový základ. Totéž co 1A, jen z druhé strany. Zeď je tvůj štít, dveře jsou hrozba.',
      ),
    ],
    
    2: [
      WcLevelConfig(
        id: 'DXPPPOW-2A',
        difficulty: 2,
        layout: 'DXPPPOW',
        description: 'Taktický ústup. Ten první maník chytře zabral flek u zdi. Nezbývá ti než jít hned k dveřím. Hlavně co nejdál od něj, prohlídka cizích nádobíček se dnes nekoná.',
      ),
      WcLevelConfig(
        id: 'WOPPPXD-2B',
        difficulty: 2,
        layout: 'WOPPPXD',
        description: 'Opačný extrém. Vzal ti flek u dveří? Nevadí, hurá ke zdi. Ne nadarmo se říká, že protiklady se ne-přitahují.',
      ),
      WcLevelConfig(
        id: 'DPPPXOW-2C',
        difficulty: 2,
        layout: 'DPPPXOW',
        description: 'Předvoj. Týpek u zdi to vzal zodpovědně. Ty musíš nechat mezeru, ale nemusíš jít úplně ke dveřím. Dvě pozice volné jsou luxus.',
      ),
      WcLevelConfig(
        id: 'WOXPPPD-2D',
        difficulty: 2,
        layout: 'WOXPPPD',
        description: 'Defenzíva u zdi. On je u dveří, ty se stáhneš. Tady jsi v bezpečí, chráněn před průvanem.',
      ),
    ],
    
    3: [
      WcLevelConfig(
        id: 'DOPXPOW-3A',
        difficulty: 3,
        layout: 'DOPXPOW',
        description: 'Dokonalá symetrie. Zlatý střed je obsazen. Necháš mezeru vlevo i vpravo. Svatý grál pisoárové vzdálenosti. Zóna klidu zaručena.',
      ),
      WcLevelConfig(
        id: 'WXPPOOD-3B',
        difficulty: 3,
        layout: 'WXPPOOD',
        description: 'Nutné zlo na okraji. Dva kámoši u dveří si povídají. Ty míříš rovnou ke zdi. Ať si to tam švitoří sami.',
      ),
      WcLevelConfig(
        id: 'DOOPPXW-3C',
        difficulty: 3,
        layout: 'DOOPPXW',
        description: 'Útěk ze stádia. U dveří je narváno. Jdeš tak daleko do rohu, jak to jen jde. Minimalizuješ šanci na oční kontakt při jejich odchodu.',
      ),
      WcLevelConfig(
        id: 'WPOXPOD-3D',
        difficulty: 3,
        layout: 'WPOXPOD',
        description: 'Rozparovač skupinek. Pustili tě doprostřed? Ber to. Rozdělíš jejich prapodivnou sestavu a nastolíš pořádek.',
      ),
    ],
    
    4: [
      WcLevelConfig(
        id: 'DOPXOOW-4A',
        difficulty: 4,
        layout: 'DOPXOOW',
        description: 'Nárazníková zóna. Dva chlapi vpravo a jeden u dveří. Zbývá ti místo mezi nimi. Těsno, ale furt máš aspoň jednu stranu krytou volným mísťem.',
      ),
      WcLevelConfig(
        id: 'WXOPOPD-4B',
        difficulty: 4,
        layout: 'WXOPOPD',
        description: 'Obklíčen zeďníkem. Ten u zdi to zabral. Střed se plní. Musíš do rohu, i když je to blíž k dalším lidem, aspoň tě kryje chladný beton.',
      ),
      WcLevelConfig(
        id: 'DXPOOPW-4C',
        difficulty: 4,
        layout: 'DXPOOPW',
        description: 'Ustupující voják. Narváno u zdi a uprostřed. Jdeš ke dveřím, i když to riskuješ, že tě trefí do zad klika. Lepší než se mačkat v davu.',
      ),
      WcLevelConfig(
        id: 'WPOOPXD-4D',
        difficulty: 4,
        layout: 'WPOOPXD',
        description: 'Záloha. Úplně to samé z druhé strany. Raději ke dveřím, než riskovat oční kontakt s pány uprostřed.',
      ),
    ],
    
    5: [
      WcLevelConfig(
        id: 'DOXPOOW-5A',
        difficulty: 5,
        layout: 'DOXPOOW',
        description: 'Check-mate zleva. Tři chlapi to zazdili. Musíš do té škvíry u dveří. Snaž se koukat přímo před sebe a dýchej pusou.',
      ),
      WcLevelConfig(
        id: 'WXOPOOD-5B',
        difficulty: 5,
        layout: 'WXOPOOD',
        description: 'Slepenec. Skupinka tří se nalepila u dveří. U zdi máš azyl. Můžeš se tvářit, že s nima vůbec, ale vůbec nepatříš do jedné místnosti.',
      ),
      WcLevelConfig(
        id: 'DOOPXOW-5C',
        difficulty: 5,
        layout: 'DOOPXOW',
        description: 'Nechtěný kompromis. Mezi dvěma pány je místo, ale napravo je další. Vybíráš menší zlo, alespoň po levé straně máš klid.',
      ),
      WcLevelConfig(
        id: 'WOOPOXD-5D',
        difficulty: 5,
        layout: 'WOOPOXD',
        description: 'Riziko u dveří. Podobná situace. Dva u zdi, jeden dál. Musíš volit místo u dveří, abys minimalizoval kontakt.',
      ),
    ],
    
    6: [
      WcLevelConfig(
        id: 'DOXOPOW-6A',
        difficulty: 6,
        layout: 'DOXOPOW',
        description: 'Labyrint. Střídavě obsazeno? Tohle je teror. Každá volba je špatně. Vybíráš X, protože... upřímně, je to loterie. Zhluboka se nadechni a soustřeď se na kachličku.',
      ),
      WcLevelConfig(
        id: 'WXOXOPD-6B',
        difficulty: 6,
        layout: 'WXOXOPD',
        description: 'Zrcadlový labyrint. Ten samý horor, akorát se zdí za zády. Zlaté pravidlo: nemluv, nekyvej, a hlavně nemiř křivě.',
      ),
      WcLevelConfig(
        id: 'DPOXOPW-6C',
        difficulty: 6,
        layout: 'DPOXOPW',
        description: 'Past na medvěda. Všichni stojí tak, že každá volba znamená stát vedle někoho. Tohle místo X ti aspoň dává mezeru z jedné strany. Buď za to vděčný.',
      ),
      WcLevelConfig(
        id: 'WPOXOOD-6D',
        difficulty: 6,
        layout: 'WPOXOOD',
        description: 'Krajní řešení. Skupinka 2 a 1 osamocený. Volíš mezeru mezi menším zlem.',
      ),
    ],
    
    7: [
      WcLevelConfig(
        id: 'DOOOXPW-7A',
        difficulty: 7,
        layout: 'DOOOXPW',
        description: 'Skupinová terapie. Čtyři chlapi v řadě? To je snad firemní teambuilding! Ty jdeš hned vedle. Hlavně se nepřidávej ke zpěvu, pokud náhodou začnou.',
      ),
      WcLevelConfig(
        id: 'WPXOOOD-7B',
        difficulty: 7,
        layout: 'WPXOOOD',
        description: 'Stádní pud u dveří. Nalepili se na sebe jak sardinky kousek od vchodu. Ty máš jedinou volbu. Ke zdi. A doufat, že ti nedojde trpělivost, než odejdou.',
      ),
      WcLevelConfig(
        id: 'DOXOOOW-7C',
        difficulty: 7,
        layout: 'DOXOOOW',
        description: 'Středový kompromis. Obsazeno na krajích a uprostřed. Tohle X je jediná šance, jak stát vedle dvou lidí najednou a zároveň se cítit absolutně odříznutý od světa.',
      ),
      WcLevelConfig(
        id: 'WOOOXPD-7D',
        difficulty: 7,
        layout: 'WOOOXPD',
        description: 'Poslední mušketýr. Tři v řadě od zdi. Zbývá jedno P. Jdeš tam, stáváš se čtvrtým mušketýrem, a modlíš se, ať se neotočí tvým směrem.',
      ),
    ],
    
    8: [
      WcLevelConfig(
        id: 'DOOOOXW-8A',
        difficulty: 8,
        layout: 'DOOOOXW',
        description: 'Poslední prázdná mušle. Není z čeho vybírat. Prostě tam jdi, udělej co musíš, a koukej vypadnout. Ruce si můžeš umýt až doma. (Nebo aspoň rychle).',
      ),
      WcLevelConfig(
        id: 'WXOOOOD-8B',
        difficulty: 8,
        layout: 'WXOOOOD',
        description: 'Samotka u zdi. Stejná mizérie, jen se zdi můžeš dotýkat ramenem pro psychickou podporu.',
      ),
    ],
  };

  static List<WcLevelConfig> getLevelsByDifficulty(int difficulty) {
    return _levels[difficulty] ?? [];
  }

  static int get maxDifficulty => _levels.keys.reduce((a, b) => a > b ? a : b);

  static List<int> get availableDifficulties => _levels.keys.toList()..sort();
  
  static bool isValidDifficulty(int difficulty) => _levels.containsKey(difficulty);
  
  static int getNextDifficulty(int current) {
    final difficulties = availableDifficulties;
    final currentIndex = difficulties.indexOf(current);
    if (currentIndex >= 0 && currentIndex < difficulties.length - 1) {
      return difficulties[currentIndex + 1];
    }
    return -1; // Konec hry
  }
  
  // Validace layoutu - D a W musí být jen na pozicích 0 a 6
  static bool isValidLayout(String layout) {
    if (layout.length != 7) return false;
    // Pozice 1-5 musí být P, O, nebo X
    for (int i = 1; i <= 5; i++) {
      if (layout[i] == 'D' || layout[i] == 'W') return false;
    }
    // Pozice 0 a 6 musí být D nebo W
    if ((layout[0] != 'D' && layout[0] != 'W') || 
        (layout[6] != 'D' && layout[6] != 'W')) return false;
    // Pozice 0 a 6 musí být opačné
    if (layout[0] == layout[6]) return false;
    return true;
  }
}

class WcLevelConfig {
  final String id;
  final int difficulty;
  final String layout;
  final String description;

  const WcLevelConfig({
    required this.id,
    required this.difficulty,
    required this.layout,
    required this.description,
  });
}
