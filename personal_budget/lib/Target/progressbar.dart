import 'package:flutter/material.dart';

class Progressbar extends StatelessWidget {
  final Color backgroundColor;
  final int value;
  final Color color;
  final double clamp;
  const Progressbar({super.key, 
    required this.backgroundColor,
    required this.color,
    required this.value, // Value must be between 0.0 and 1.0
    required this.clamp,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.5; // Dynamic size

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circular Progress (Track)
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: value.toDouble(), // Full track
              backgroundColor: backgroundColor,
              strokeWidth: 22,
            ),
          ),
 SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: clamp.clamp(0.0, 1.0), // Ensure value is between 0 and 1
                strokeWidth: 22,
                backgroundColor:Colors.grey, // Hide background
valueColor: AlwaysStoppedAnimation<Color>(color)
              ),
            ),
          // Display Percentage in Center
          Text(
            "${value.toStringAsFixed(0)}%", // Convert to percentage
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
