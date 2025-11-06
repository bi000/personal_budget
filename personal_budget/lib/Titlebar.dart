
import 'package:flutter/material.dart';

class TITLE extends StatelessWidget{
  const TITLE({super.key});

  @override
  Widget build(BuildContext context){
    return AppBar(
  flexibleSpace: Padding(padding: EdgeInsets.only(top: 1.0),
      child:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
      ),
    );
  }
}