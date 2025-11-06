import 'package:flutter/material.dart';

class txtData{
static Widget  targetInformation(BuildContext context,String content,int data,){
  return Padding(padding: EdgeInsets.only(right: 10,bottom: 5),
        child:
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('$content:$data',style: TextStyle(color: Colors.black),),
          ],
        ),
        );
}
static Widget targetInformation2(BuildContext context,String content2,int data2){
    return Padding(padding: EdgeInsets.only(right: 10,bottom: 5),
        child:
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('$content2:$data2',style: TextStyle(color: Colors.black),),
          ],
        ),
        );
}
}