import 'package:flutter/material.dart';
import 'package:personal_budget/Target/progressbar.dart';
import 'package:personal_budget/Target/linearProgress.dart';
import 'package:personal_budget/Target/textData.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/providerData.dart';
import 'package:provider/provider.dart';
class Target extends StatefulWidget{
  const Target({super.key});

  @override
  _Target createState()=>_Target();
}
class _Target extends State<Target>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Target',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
       flexibleSpace: TITLE(),
       centerTitle: true,
      ),
      body:Consumer<dataCalculation>(builder:(context,data,child){ 
      List<dynamic> totalDebtAmount=data.totalDebt;
      List<dynamic> LimitData=data.LimitAmount;
      List<dynamic> SavingAllocation=data.LimitAmount;
      List<dynamic> dailyPay=data.dailyDebtPay;
            List<dynamic> Income=data.getAmount;
            List<dynamic> expenditure=data.getAmount2;
      int totalDebt=totalDebtAmount.fold(0,(previous,current)=>previous+ (current as int));
      int totalLimit=LimitData.fold(0,(previous,currentData)=>previous+(currentData as int));
      int totalSaving=SavingAllocation.fold(0,(previous,currentElement)=>previous+(currentElement as int));
      int totalIncome=Income.fold(0,(pre,nex)=>pre+(nex as int));
      int totalExpen=expenditure.fold(0,(previous,currentIncome)=>previous+(currentIncome as int));
      int totalDailyPayment=dailyPay.fold(0, (current,next)=>current +(next as int));
      int Saving=SavingAmount(totalIncome,totalExpen);
      int BudgetAllocation=percentage(totalExpen, totalSaving);
      double ClamValue=BudgetAllocation/100;
      int Save=percentage(Saving,totalLimit);
            double ClamValue2=Save/100;
int debtPayPercent = percentage(totalDailyPayment ?? 0, totalDebt ?? 0);
      double debtDecimal=debtPayPercent/100;

      print('DailyPay$debtPayPercent');
      print(totalLimit);
      print('percentage:$Save');
 
      return SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(8.0),
        child: SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Column(
          children: [
              Padding(padding:EdgeInsets.all(7.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Debt Progress:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 18.0),),
                ],
              ),
            )
        ),
Card(
  color: Colors.white,
  elevation: 10.0,
  shadowColor: Colors.black87,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  child: SizedBox(
    width: MediaQuery.of(context).size.width*1,
    height: MediaQuery.of(context).size.height*0.37,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       txtData.targetInformation(context,' Debt',totalDebt,),
       txtData.targetInformation2(context,'Paid',totalDailyPayment),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Progressbar(backgroundColor: Colors.grey, color:Colors.purple, value: debtPayPercent,clamp: debtDecimal,)
          ],
        ),
       
      ],
    ),
  ),
),
  Padding(padding:EdgeInsets.all(7.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Expenses Allocation:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 18.0),),
                ],
              ),
            )
        ),
Padding(padding: EdgeInsets.all(1.0),
child:Card(
  color: Colors.white,
  elevation: 10.0,
  shadowColor: Colors.black87,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  child: SizedBox(
    width: MediaQuery.of(context).size.width*1,
    height: MediaQuery.of(context).size.height*0.3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        txtData.targetInformation(context,'Limit',totalSaving),
        txtData.targetInformation2(context,'Expenses',totalExpen),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        LinearProgressBar(backgroundColor: Colors.grey, gradientColors:[Colors.blue,Colors.purple, Colors.purple], value: BudgetAllocation,clamVal: ClamValue,),
        ],
        ),
      ],
    ),
  ),
),
),
   Padding(padding:EdgeInsets.all(7.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Saving Goal:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 18.0),),
                ],
              ),
            )
        ),
Card(
  color: Colors.white,
  elevation: 10.0,
  shadowColor: Colors.black87,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  child: SizedBox(
    width: MediaQuery.of(context).size.width*1,
    height: MediaQuery.of(context).size.height*0.37,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        txtData.targetInformation(context,'SavingTarget',totalLimit),
        txtData.targetInformation2(context,'Expenses',Saving),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Progressbar(backgroundColor: Colors.grey, color:Colors.purple, value: Save,clamp: ClamValue2,)
          ],
        )
      ],
    ),
  ),
),
 Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width*0.5,40),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                elevation: 10.0,
                shadowColor: Colors.grey
              ),
              onPressed: (){
              showDialog(context: context,
               builder:(Context){
                return AlertDialog(
                  content:Text('Do you want to delete all data?'),
                  actions: [
                    TextButton(onPressed:(){
                      Navigator.of(context).pop();
                    }, child:Text('NO')),
                    TextButton(onPressed: (){
                  Provider.of<dataCalculation>(context,listen: false).deleteTargetData();
                Provider.of<dataCalculation>(context,listen: false).deleteDebtPay();
                Navigator.of(context).pop();
                    }, child:Text("Yes")),
                  ],
                );
               });
              },
              child: Text('Delete Info',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            )
          ],
        ),
          ],
        ),
        )
        ),
      );
      })
    );
  }
  int SavingAmount(int income,int expenditure){
    if(income == 0|| expenditure == 0){
      return 0;
    }
    else{
     int Sum=income-expenditure;
     return Sum;
    }
  }
  int percentage(int obtain,int alltotal){
    if(alltotal == 0){
      return 0;
    }
    else{
      double totalPercentage=obtain/alltotal*100;
    int total=totalPercentage.round();
    return total;
    }
  }
}