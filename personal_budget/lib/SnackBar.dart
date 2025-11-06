import 'package:flutter/material.dart';

class Snackbar {
  static void showSnackBar(BuildContext context ,String content){
    final snackbar= SnackBar(
          content: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            ),
            child: Center(
              child: Text(
                'Please fill all the fields!',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ),
          ),
          duration: Duration(seconds: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
          elevation: 10.0,
          padding: EdgeInsets.only(top: 2.0),
          backgroundColor: Colors.transparent,
        );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}