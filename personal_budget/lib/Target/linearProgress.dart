import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  final int value; 
  final double clamVal;// Must be between 0.0 and 1.0
  final Color backgroundColor;
  final List<Color> gradientColors; // Gradient support

  const LinearProgressBar({super.key, 
    required this.value,
    required this.backgroundColor,
    required this.gradientColors,
    required this.clamVal
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen width

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Background Bar
          Container(
            width: width,
            height: 20,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Foreground Progress Bar (Animated)
          AnimatedContainer( 
            duration: Duration(milliseconds: 500),// Smooth animation
            width: width * clamVal.clamp(0.0, 1.0), // Ensures valid progress
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Percentage Text Display
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${value.toStringAsFixed(0)}%", // Format as percentage
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
