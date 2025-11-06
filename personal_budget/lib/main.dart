import 'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import 'package:personal_budget/BottomNavigation/AboutUs.dart';
import 'package:personal_budget/BottomNavigation/ContactUs.dart';
import 'package:personal_budget/Drawer.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/UI.dart';
import 'package:personal_budget/providerData.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();//firebase initializing....
  await Firebase.initializeApp();
  runApp( 
    ChangeNotifierProvider(// provider initializing.......
      create: (_)=>dataCalculation(),
    child:MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  )
  ),
  );
}
class App extends StatefulWidget{
  const App({super.key});

  @override
  my_App createState()=> my_App();
}
class my_App extends State<App>{
  int Current_index=0;
  @override
Widget build(BuildContext context){
  return Scaffold(
  
    appBar:AppBar(
        leading:Builder(builder: (BuildContext context){
        return IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        );
      }
      ),
      title: Text('PocketPlan',style: TextStyle(color:Colors.white, fontWeight:FontWeight.normal,letterSpacing: 1.5),),
      flexibleSpace: 
     TITLE(),
      centerTitle:true,
      actions: [
Builder(builder: (BuildContext context){
    return SizedBox(
      child: Padding(padding: EdgeInsets.only(right: 10),
     child:IconButton(
          icon: CircleAvatar(
            child: Icon(Icons.person,size: 40,color:Colors.blue,),
          ),
          onPressed: (){
          },
        ) ,
      ),
    );
      }
      ),
      ],
    ),
    drawer: drawerWidget(),
    body:Container(
      child: UI(),
    ),
     bottomNavigationBar: ClipRRect(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple], // Gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    ),
    child: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info, size: 28),
          label: "About Us",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_phone, size: 28),
          label: "Contact Us",
        ),
      ],
      currentIndex: Current_index,
      onTap: (index) {
        setState(() {
          Current_index = index;
        });
        if(Current_index==0){
          Navigator.push(context,
           MaterialPageRoute(builder:(BuildContext context)=>App()));
        }
        else if(Current_index==1){
           Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => about(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // Slide in from right
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(position: offsetAnimation, child: child);
                    },
                  ),
                );
              }
        else if(Current_index==2){
            Navigator.push(context,
            PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation)=>contact(),
            transitionsBuilder: (context,animation,secondaryAnimation,child){
              const begin=Offset(1.0, 0.0);
              const end=Offset.zero;
              const curve=Curves.easeOutCubic;
              var tween=Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
              var offsetAnimation=animation.drive(tween);
              return SlideTransition(position: offsetAnimation,child: child,);
            }
            )
            );
        }
      },
      backgroundColor: Colors.transparent, // Transparent to show gradient
      showSelectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
  ),
     )
  );
}
}