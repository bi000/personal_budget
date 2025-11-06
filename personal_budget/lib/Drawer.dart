import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class drawerWidget extends StatelessWidget{
  const drawerWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      width: MediaQuery.of(context).size.width*0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Padding(padding: EdgeInsets.only(left: 10),
            child: Text('Name'),
            ),
             accountEmail: Text('aaa@gmail.com'),
             currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
               child: Icon(Icons.person, size: 40, color: Colors.blue),
             ),
             ),
             ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock),
              onTap: (){

              },
             ),
             ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.logout),
              onTap: (){
                showDialog(context: context,
                 builder: (context){
                  return AlertDialog(
                    content: Text('Do you want to close app?'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child:Text("NO")),
                      TextButton(onPressed:(){
                        SystemNavigator.pop();
                      }, child: Text("Yes"))
                    ],
                  );
                 });
              },
             )
        ],
      ),
    );
  }
}