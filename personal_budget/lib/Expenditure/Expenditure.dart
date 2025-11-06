import 'package:flutter/material.dart';
import 'package:personal_budget/Expenditure/dropdown.dart';
import 'package:personal_budget/Expenditure/firebaseConnection.dart';
import 'package:personal_budget/Expenditure/payment.dart';
import 'package:personal_budget/Income/input.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/Income/dropdown.dart';
import 'package:personal_budget/showDialog.dart';
class Expenditure extends StatefulWidget{
  const Expenditure({super.key});

  @override
  _personalExpenditure createState()=>_personalExpenditure();
}
class _personalExpenditure extends State<Expenditure>{
  final Service _firbaseConnection=Service();//creating object of class Name Service
 final TextEditingController _items=TextEditingController();
  final  TextEditingController _spendAmount=TextEditingController();
    final    TextEditingController _payment=TextEditingController();
      final     TextEditingController _paid=TextEditingController();
       final      TextEditingController _paidLocaton=TextEditingController();
         final   TextEditingController _paidDate=TextEditingController();
      Map<String,dynamic> expenditure={};
      List<int>Amo_collection=[];
      String alertContent='Expenditure added success';
@override


  void dispose(){
    _items.dispose();
    _spendAmount.dispose();
    _payment.dispose();
    _paid.dispose();
    _paidLocaton.dispose();
    _paidDate.dispose();
    super.dispose();
  }
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
       title: Text('Expenditure',style: TextStyle(color:Colors.white, fontWeight:FontWeight.normal,letterSpacing: 1.5),),
        centerTitle: true,
        flexibleSpace:TITLE() ,
    ),
    body: SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          children: [
            Padding(padding:EdgeInsets.only(top: 20.0),
            child:
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('DailyExpenditure:',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 18.0),)
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
            incomeDropDownField(label:'Item', controller: _items),
        incomeInputField(label: 'Amount', controller:_spendAmount, hint: 'Paid Amount', keyboardType: TextInputType.number,),
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
            incomePaymentField(label: 'method', controller: _payment),
        incomeInputField(label: 'Paid To', controller:_paid, hint: 'person/hotel/office', keyboardType: TextInputType.text,),
          ],
        ),
      )
        ),
           Padding(padding: EdgeInsets.only(left: 9.0,top: 50.0),
        child: 
      SizedBox(
        width: MediaQuery.of(context).size.width*1,
        child: Row(
          children: [
        incomeInputField(label: 'Payment Location', controller: _paidLocaton, hint: 'nayabazar,kathmandu',keyboardType: TextInputType.text,),
        MonthDropdownInputField(label: 'selectDate', controller: _paidDate,)
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
                expendDetails(_items.text, _spendAmount.text, _payment.text, _paid.text, _paidLocaton.text, _paidDate.text);
                _items.clear();
                _spendAmount.clear();
                _paid.clear();
                _payment.clear();
                _paidLocaton.clear();
                _paidDate.clear();
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
      ),
    )
  );
}
void expendDetails(String items,String Samount,String payMethod,String paidTo,String payLocate,String payDate){
  setState(() {
    if(items.isNotEmpty && Samount.isNotEmpty && payMethod.isNotEmpty && paidTo.isNotEmpty && payLocate.isNotEmpty && payDate.isNotEmpty){
      expenditure={
        'ITEMS':items,
        'AMOUNT':int.parse(Samount),
        'PAYMETHOD':payMethod,
        'PAIDTO':paidTo,
        'PAYLOCATION':payLocate,
        'PAYDATE':payDate
      };
      _firbaseConnection.addIncomeData(expenditure).then((_){
        Showdialog.ShowAlert(context,alertContent);
      }).catchError((e){
        print(e);
      });
    }
    else{
       final snackbar = SnackBar(
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
  });
}
int TotalSpend(int Amo){
if(Amo==0){
return 0;
}
else{
  Amo_collection.add(Amo);
  int arraySum=Amo_collection.fold(0, (previous,element){
    return previous+element;
  });
  return arraySum;
}
}
}