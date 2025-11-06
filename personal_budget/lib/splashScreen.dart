import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _aniController;
  late Animation<double> _animate;

  @override
  void initState() {
    super.initState();

    // Animation Setup
    _aniController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 500),
    )..forward();

    _animate = CurvedAnimation(
      parent: _aniController,
      curve: Curves.bounceInOut,
    );

    // Navigate to home screen after animation completes
    Timer(Duration(seconds: 500), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  void dispose() {
    _aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animate,
          child: Image.asset('Image/Logo.png',width: 150,),
        ),
      ),
    );
  }
}
