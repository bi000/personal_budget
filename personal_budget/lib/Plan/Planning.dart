import 'package:flutter/material.dart';
import 'package:personal_budget/Income/dropdown.dart';
import 'package:personal_budget/Plan/firbaseConnect.dart';
import 'package:personal_budget/Income/input.dart';
import 'package:personal_budget/SnackBar.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/showDialog.dart';
class Planning extends StatefulWidget{
  const Planning({super.key});

  @override
  _myPlanning createState()=>_myPlanning();
}
class _myPlanning extends State<Planning>{
 final TextEditingController _debt=TextEditingController();
final  TextEditingController debtDate=TextEditingController();
final  TextEditingController _itmePlan=TextEditingController();
final  TextEditingController expenDate=TextEditingController();
final  TextEditingController _SaveAmo=TextEditingController();
final  TextEditingController savingDate=TextEditingController();
final  TextEditingController _debtPayment=TextEditingController();
final  TextEditingController _payDate=TextEditingController();
@override
  void dispose(){
    _debt.dispose();
    debtDate.dispose();
    _itmePlan.dispose();
    expenDate.dispose();
    _SaveAmo.dispose();
    savingDate.dispose();
    _debtPayment.dispose();
    _payDate.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning Information',style:TextStyle(color: Colors.white),),
       flexibleSpace:TITLE(),
      ),
      body:SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*1,
          child: Column(
            children:[
    Padding(padding:EdgeInsets.all(7.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Debt plan:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 20.0),),
                ],
              ),
            )
        ),
      Padding(padding: EdgeInsets.only(left: 5.0,top:1.0 ),
        child:  SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
          children: [
        incomeInputField(label: 'Debt Amount ', controller: _debt, hint: 'Your Name',keyboardType: TextInputType.number,),
        MonthDropdownInputField(label: 'text', controller: debtDate),
          ],
        ),
      )
        ),
       
         Padding(
          padding:EdgeInsets.only(top: 15.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Budget Allocation:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 20.0),),
                ],
              ),
            )
        ),

         Padding(padding: EdgeInsets.only(left: 9.0),
        child: 
      SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
          children: [
        incomeInputField(label: 'Limit Expendtiure', controller: _itmePlan, hint: 'Add Limit',keyboardType: TextInputType.number,),
        MonthDropdownInputField(label: 'limit', controller: expenDate),
          ],
        ),
      )
        ),
         
  Padding(
          padding:EdgeInsets.only(top: 15.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("SavingGoals:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 20.0),),
                ],
              ),
            )
        ),
             Padding(padding: EdgeInsets.only(left: 9.0),
        child: 
      SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
          children: [
        incomeInputField(label: 'Amount', controller: _SaveAmo, hint: 'SavingAmount',keyboardType: TextInputType.number,),
          MonthDropdownInputField(label: 'saving', controller: savingDate),
          ],
        ),
      )
        ),
          Padding(padding: EdgeInsets.only(left: 9.0,top: 5.0),
        child: 
      SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
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
                planDataCollection(
                  _debt.text,
                  debtDate.text,
                  _itmePlan.text,
                expenDate.text,
                _SaveAmo.text,
                savingDate.text
                );
                _debt.clear();
                debtDate.clear();
                _itmePlan.clear();
                expenDate.clear();
                _SaveAmo.clear();
                savingDate.clear();
              },
              child: Text('Add',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      )
        ), 
         Padding(
          padding:EdgeInsets.only(top: 15.0),
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Loan Payment Field:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,wordSpacing:2.0,fontSize: 20.0),),
                ],
              ),
            )
        ),
         SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
          children: [
        incomeInputField(label: 'Amount', controller: _debtPayment, hint: 'loadPay',keyboardType: TextInputType.number,),
        MonthDropdownInputField(label: 'Duration(Months) ', controller:_payDate),
          ],
        )
      ), Padding(padding: EdgeInsets.only(left: 9.0,top: 5.0),
        child: 
      SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
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
                loanPayment(_debtPayment.text,_payDate.text);
                _debtPayment.clear();
                _payDate.clear();
              },
              child: Text('Add',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      )
        ),
          ],
          ),
        ),
      )
    );
  }
  void planDataCollection(String debtAmount,String PlanMonths,String LimitAmount,String PlanMonths1,String SaveAmo,String PlanMonths2 ){
    setState(() {
      if((debtAmount.isNotEmpty && PlanMonths.isNotEmpty) || (LimitAmount.isNotEmpty && PlanMonths1.isNotEmpty) || (SaveAmo.isNotEmpty && PlanMonths2.isNotEmpty)){
    Map<String,dynamic> planData={
      'DEBT':int.tryParse(debtAmount) ?? 0,
      'DEBTDATE':PlanMonths,
      'LIMIT':int.tryParse(LimitAmount)??0,
      'LIMITDATE':PlanMonths1,
      'SAVEAMO':int.tryParse(SaveAmo)??0,
      'SAVEDATE':PlanMonths2
    };
    FirbaseConnect().addPlanData(planData).then((_){
      Showdialog.ShowAlert(context, 'Data Added Success!');
    }).catchError((error){
      print('Failed to add data $error');
    });
      }
      else{
        Snackbar.showSnackBar(context, 'One of them required');
      }
    });
  }

  void loanPayment(String loanAmount,String Date){
setState(() {
  if(loanAmount.isNotEmpty && Date.isNotEmpty){
    Map<String,dynamic> paymentData={
      'PAY':int.tryParse(loanAmount),
      'DATE':Date,
    };
    FirbaseConnect().debtPayment(paymentData).then((_){
      Showdialog.ShowAlert(context, 'Data added success!');
    }).catchError((error){
      print('Failed to add data $error');
    });
  }
  else{
    Snackbar.showSnackBar(context, 'data are required');
  }
});
  }
}