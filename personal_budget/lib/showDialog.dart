import 'package:flutter/material.dart';
class Showdialog {
  static void ShowAlert(BuildContext context,String  content){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Success',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                    Center(
                  child:Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                    )
                  
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            );
          },
        );
  }
}