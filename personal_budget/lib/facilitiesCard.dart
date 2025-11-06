import 'package:flutter/material.dart';

class facilitiesCard extends StatelessWidget{
final String title;// getting title Ui 
final IconData icon; //getting icon
final VoidCallback onTap; // storing void call back function 
const facilitiesCard(
  {
    super.key,
    required this.title,// provides title datavalue form list map
    required this.icon, //provides icon datavalue form list map 
    required this.onTap // provides call back function 
    
  }
);
@override
Widget build(BuildContext context){
  return GestureDetector(
    onTap: onTap,
    child:Container(
      width:MediaQuery.of(context).size.width*0.3,
      height:MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 4,
          color: Colors.black12,
          offset: Offset(2,2)
          )
        ]
         ),
         child: Center(
          child: Column(
         mainAxisAlignment:MainAxisAlignment.center,
            children: [
            Icon(icon),
            Text(title),
          ],),
         ),
    )
  );
}
}