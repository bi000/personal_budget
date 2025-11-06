import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class dataCalculation extends ChangeNotifier{
  Map<String,dynamic> _data1={};//creating null map variable(underscore makes it private and safe)
    Map<String,dynamic> _data2={};//creating null map variable
    Map<String,dynamic> _planData={};
    Map<String,dynamic> _dailyPay={};
  Map<String,dynamic>get data1=>_data1;// using getter returning the value _data1 to function data1(this is a shorthand function)
  Map<String,dynamic>get data2=>_data2;// using getter returning the value _data2 to function data1(this is a shorthand function)
  Map<String,dynamic> get planData=>_planData;
  Map<String,dynamic> get dailyPayment=>_dailyPay;
dataCalculation(){
  calculate();//fetching data when provider is initialized
calculate2();
fetchPlanData();
fetchDailyPay();
}
  Future<void> calculate()async{
try {
  Query ref=FirebaseDatabase.instance.ref().child('pocketplan');//getting database reference from firebase
ref.onValue.listen((event){//listen real time database event and notify to the UI
  if(event.snapshot.value!=null){
_data1=Map<String,dynamic>.from(event.snapshot.value as Map);
notifyListeners();
}
else{
  _data1={};
  notifyListeners();
}
});
}catch (e) {
  print(e);
}
  }
  Future<void> calculate2()async{
  try {
    Query ref2=FirebaseDatabase.instance.ref().child('expenditure');
   ref2.onValue.listen((event){//this is real-time database event that listen value changes in firbase and notify to the ui so that our app react on vlaue change
 if(event.snapshot.value!=null){
      _data2=Map<String,dynamic>.from(event.snapshot.value as Map);
      notifyListeners();
    }
    else{
      _data2={};
      notifyListeners();
    }
   });
  } catch (e) {
    print(e);
  }
  }
Future<void> fetchPlanData()async{
Query planDataRef=FirebaseDatabase.instance.ref().child('planData');
planDataRef.onValue.listen((event){// listen real time database changes and notify to the UI
  if(event.snapshot.value!=null){
  _planData=Map<String,dynamic>.from(event.snapshot.value as Map);
    notifyListeners();
  }
  else{
    _planData={};
    notifyListeners();
  }
});
}
Future<void> fetchDailyPay()async{
  Query dailyPaym=FirebaseDatabase.instance.ref().child('debtPay');
  dailyPaym.onValue.listen((event){
    if(event.snapshot.value!=null){
      _dailyPay=Map<String,dynamic>.from(event.snapshot.value as Map);
      notifyListeners();
    }
    else{
      _dailyPay={};
      notifyListeners();
    }
  });
}

  Future<void> removeIndexData(String doc)async{//asynchoronus code for deleting and updating ui
    try {
      await FirebaseDatabase.instance.ref().child('pocketplan').child(doc).remove();//curd operation deleting data
  //removing data 
  data1.remove(doc);
notifyListeners();
    } catch (e) {
      print(e);
    }
  }
Future<void> removeExpenData(String docid2)async{
  try {
    await FirebaseDatabase.instance.ref().child('expenditure').child(docid2).remove();
    //Removing and notify Widget
    data2.remove(docid2);
    notifyListeners();
  } catch (e) {
    print(e);
  }
}
Future<void> deleteTargetData()async{
try {
  await FirebaseDatabase.instance.ref().child('planData').remove();
  notifyListeners();
} catch (e) {
  print('error$e');
}
}
Future<void> deleteDebtPay()async{
try {
  await FirebaseDatabase.instance.ref().child('debtPay').remove();
  notifyListeners();
} catch (e) {
  print('Error$e');
}
}

  List<dynamic>get  getAmount{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _data1.values.map((databaseData)=>databaseData["INCOME"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((amount)=>amount!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
    List<dynamic>get  getAmount2{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _data2.values.map((databaseData)=>databaseData["AMOUNT"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((amount)=>amount!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
     List<dynamic>get  getMonths{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _data1.values.map((databaseData)=>databaseData["MONTHS"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((months)=>months!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
       List<dynamic>get  getMonths2{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _data2.values.map((databaseData)=>databaseData["PAYDATE"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((Mont)=>Mont!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
       List<dynamic>get totalDebt{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _planData.values.map((databaseData)=>databaseData["DEBT"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((Mont)=>Mont!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
     List<dynamic>get LimitAmount{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _planData.values.map((databaseData)=>databaseData["LIMIT"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((Mont)=>Mont!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
     List<dynamic>get savingAmount{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _planData.values.map((databaseData)=>databaseData["SAVEAMO"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((Mont)=>Mont!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }
       List<dynamic>get dailyDebtPay{//extracting the only amount value from the database 
  //_data1.values ignors all the key created by firebasebe like(: {-OKqt9gTyvIPnTHqPDTk: {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal} 
  //like {MONTHS: 1, OCCU: Teaching , INCOME: 30000, NAME: Bishal}
    return _dailyPay.values.map((databaseData)=>databaseData["PAY"])// .map stores key vlaue pair and extract value AMOUNT key vlaue only
    .where((Mont)=>Mont!=null)//where function filter if list has any null value or not if null it removes 
    .toList();//keeps data in list 
  }

}