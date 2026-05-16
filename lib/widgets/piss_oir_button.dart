import 'package:flutter/material.dart';
import '../models/game_level.dart';

class PissOirButton extends StatelessWidget {
  final PissOir pissOir;
  final bool isSelected;
  final VoidCallback onTap;

  const PissOirButton({
    super.key,
    required this.pissOir,
    required this.isSelected,
    required this.onTap,
  });

  IconData get _icon {
    switch (pissOir.type) {
      case PissOirType.classic:
        return Icons.wc;
      case PissOirType.urinal:
        return Icons.water_drop;
      case PissOirType.squat:
        return Icons.accessible;
      case PissOirType.bidet:
        return Icons.water;
      case PissOirType.tree:
        return Icons.park;
      case PissOirType.bottle:
        return Icons.local_drink;
      case PissOirType.bush:
        return Icons.grass;
    }
  }

  Color get _color {
    switch (pissOir.type) {
      case PissOirType.classic:
        return const Color(0xFF8B4513);
      case PissOirType.urinal:
        return Colors.blue;
      case PissOirType.squat:
        return Colors.teal;
      case PissOirType.bidet:
        return Colors.cyan;
      case PissOirType.tree:
        return Colors.green;
      case PissOirType.bottle:
        return Colors.purple;
      case PissOirType.bush:
        return Colors.lightGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? _color.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? _color : Colors.grey.shade300,
            width: isSelected ? 4 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                ? _color.withOpacity(0.4) 
                : Colors.black.withOpacity(0.1),
              blurRadius: isSelected ? 12 : 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icon,
              size: 48,
              color: _color,
            ),
            const SizedBox(height: 8),
            Text(
              pissOir.label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? _color : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            if (pissOir.hint != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  pissOir.hint!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
