import 'dart:math';

class AssetLoader {
  static final Random _random = Random();
  
  // Seznam známých souborů v media složce
  static const List<String> _pissoirLightImages = [
    'media/pissoir-1-light.png',
    'media/pissoir-2-light.png',
    'media/pissoir-3-light.png',
    'media/pissoir-4-light.png',
    'media/pissoir-5-light.png',
  ];
  
  static const List<String> _pissoirDarkImages = [
    'media/pissoir-1-dark.png',
    'media/pissoir-2-dark.png',
    'media/pissoir-3-dark.png',
    'media/pissoir-4-dark.png',
    'media/pissoir-5-dark.png',
  ];
  
  static const List<String> _manImages = [
    'media/man-1.png',
    'media/man-2.png',
    'media/man-3.png',
    'media/man-4.png',
  ];
  
  static const List<String> _doorImages = [
    'media/door-1.png',
    'media/door-2.png',
    'media/door-3.png',
    'media/door-4.png',
  ];
  
  static const List<String> _wallImages = [
    'media/wall-1.png',
    'media/wall-2.png',
    'media/wall-3.png',
  ];
  
  // Sledování použitých obrázků pro danou úroveň
  static Set<String> _usedPissoirs = {};
  static Set<String> _usedMen = {};
  static Set<String> _usedDoors = {};
  static Set<String> _usedWalls = {};

  /// Vybere náhodný obrázek z kolekce
  static String getRandomImage(List<String> images, {Set<String>? used}) {
    if (images.isEmpty) return '';
    
    // Filtruj již použité
    var available = images;
    if (used != null && used.isNotEmpty) {
      available = images.where((img) => !used.contains(img)).toList();
      // Pokud jsou všechny použité, reset
      if (available.isEmpty) {
        used.clear();
        available = images;
      }
    }
    
    final selected = available[_random.nextInt(available.length)];
    used?.add(selected);
    return selected;
  }

  /// Vybere náhodný pissoir
  static String getRandomPissoir({bool darkMode = false}) {
    final images = darkMode ? _pissoirDarkImages : _pissoirLightImages;
    return getRandomImage(images, used: _usedPissoirs);
  }

  /// Vybere náhodného muže
  static String getRandomMan() {
    return getRandomImage(_manImages, used: _usedMen);
  }

  /// Vybere náhodné dveře
  static String getRandomDoor() {
    return getRandomImage(_doorImages, used: _usedDoors);
  }

  /// Vybere náhodnou zeď
  static String getRandomWall() {
    return getRandomImage(_wallImages, used: _usedWalls);
  }

  /// Vymazání cache použitých obrázků (pro novou úroveň)
  static void clearCache() {
    _usedPissoirs.clear();
    _usedMen.clear();
    _usedDoors.clear();
    _usedWalls.clear();
  }
}
