import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final int seconds;

  const GameTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final isLow = seconds <= 10;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isLow ? Colors.red.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLow ? Colors.red : Colors.blue,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: isLow ? Colors.red : Colors.blue,
          ),
          const SizedBox(width: 4),
          Text(
            '${seconds}s',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isLow ? Colors.red : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
