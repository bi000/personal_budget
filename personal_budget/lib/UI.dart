import 'package:flutter/material.dart';
import 'package:personal_budget/facilitiesCard.dart';
import 'package:personal_budget/Income/Income.dart';
import 'package:personal_budget/Expenditure/Expenditure.dart';
import 'package:personal_budget/Charts/Graph.dart';
import 'package:personal_budget/Download.dart';
import 'package:personal_budget/Plan/Planning.dart';
import 'package:personal_budget/Target/Target.dart';
import 'package:personal_budget/Reminder.dart';
import 'package:personal_budget/providerData.dart';
import 'package:provider/provider.dart';
class UI extends StatefulWidget{
  const UI({super.key});

  @override
   _Budget createState()=> _Budget();
}
class _Budget extends State<UI>{

  final List<Map<String,dynamic>> cardData=[ //creatign list map object to store title and iconsl
    {
      'Title':'Add Income',
      'icon':Icons.attach_money
  },
    {
      'Title':'Expenditure',
      'icon':Icons.remove_circle_outline
  },
    {
      'Title':'Graph',
      'icon':Icons.show_chart
  },
    {
      'Title':'Download',
      'icon':Icons.download
  },  {
      'Title':'Planning',
      'icon':Icons.calendar_today
  },
   {
      'Title':'SavingGoals',
      'icon':Icons.savings
  },
  {
      'Title':'Reminder',
      'icon':Icons.timer
  }
  ];

  final List<Map<String,dynamic>> UiInfo=[
    {
      'Title':'Your Saving:',
      'money':0.00,
      'Icon':Icons.account_balance,
  },
  {
    'Title':'Expenditure:',
    'money':0.00,
    'Icon':Icons.trending_down
  },
  {
    'Title':'Income:',
    'money':0.00,
    'Icon':Icons.money
  }
  ];
@override
Widget build(BuildContext context){
  return Consumer<dataCalculation>(builder:(context,datacalc,child){// accessing data from provider
  List<dynamic> incomeList=datacalc.getAmount;
  List<dynamic> expenditrueList=datacalc.getAmount2;
  int totalIncome=incomeSumData(incomeList);
  int totalExpenses=incomeSumData(expenditrueList);
  int saving=Saving(totalIncome,totalExpenses);
  //dynamically updating the value 
       List<Map<String, dynamic>> updatedUiInfo = List.from(UiInfo); //getting list of UI info
      updatedUiInfo[2]['money'] = totalIncome; // Update the 'Income' entry's money value
       updatedUiInfo[1]['money'] = totalExpenses;
       updatedUiInfo[0]['money']=saving; // Update the 'Income' entry's money value

return  SingleChildScrollView(
    child: 
   SizedBox(
    width: MediaQuery.of(context).size.width*1,
  child: Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width*1,
        child: Wrap(
          spacing: 2,
          children:UiInfo.map((Info){
          return SizedBox(
            width: MediaQuery.of(context).size.width*0.32,
            height: MediaQuery.of(context).size.height*0.13,
            child: Card(
              color:Colors.white,
              shadowColor: Colors.grey,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child:Padding(padding:EdgeInsets.all(5) ,
              child:  Center(
                child: Column(
                  children: [
                    Icon(Info['Icon']),
                    Text(Info['Title'],style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('Rs:${Info['money']}'),
                  ],
                ),
              ),
              ),
            ),
          );
          }).toList()
        )
      ),
      Text("Facilities:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      Padding(
        padding: EdgeInsets.all(3),
        child: Wrap( //wrap the items within width provide by the device screen
          spacing:6,
          runSpacing:8,
          children:cardData.map((card){
            return facilitiesCard(title:card['Title'],//passing the card datavalue to facilitiesCard function with variable title
            icon:card['icon'],
            onTap:(){
              switch(card['Title']){
                case'Add Income':
                Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>Income()));
                 break;
                 case 'Expenditure':
                 Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>Expenditure()));
                  break;
                  case 'Graph':
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context)=>Graph()));
                   break;
                   case 'Download':
                   Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Download()));
                    break;
                    case 'Planning':
                    Navigator.push(context,
                     MaterialPageRoute(builder:(context)=>Planning()));
                     break;
                    case'SavingGoals':
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>Target()));
                     break;
                     case 'Reminder':
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>Reminder()));
                       break;
              }
            }
            );
          }).toList()
        ),
      )
      ],
  ),
  ), 
  );
    });
}
int incomeSumData(List<dynamic> Income){
  if(Income.isEmpty){
    return 0;
  }
  else{
   return Income.fold(0, (previous,element)=>previous+(element as int));
  }
}
int Saving(int Inc,int expenses){
  if(Inc!=0 && expenses!=0){
    return Inc-expenses;
  }
  else {
    return 0;
  }
}
}