import 'package:flutter/material.dart';
import 'package:personal_budget/Income/dropdown.dart';
import 'package:personal_budget/Income/input.dart';
import 'package:personal_budget/SnackBar.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/Income/firebaseService.dart';
import 'package:personal_budget/showDialog.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  myIncome createState() => myIncome();
}

class myIncome extends State<Income> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _occupation = TextEditingController();
  final TextEditingController _InAmount = TextEditingController();
  final TextEditingController _months = TextEditingController();
  final TextEditingController _name1 = TextEditingController();
  final TextEditingController _occupation1 = TextEditingController();
  final TextEditingController _InAmount1 = TextEditingController();
  final TextEditingController _months1 = TextEditingController();
final Firebaseservice firebaseservice=Firebaseservice();
  bool isLoading=false;
  String alertTitle='Expenditure details have been added successfully!';
  Map<String, dynamic> MonthlyBasis = {};
  String snackBarContent='Please fill all the fields';
     List<int> IncomeAmount = [];
  @override
  void dispose() {
    _name.dispose();
    _occupation.dispose();
    _InAmount.dispose();
    _months.dispose();
    _name1.dispose();
    _occupation1.dispose();
    _InAmount1.dispose();
    _months1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
  title: Text('Income',style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
  centerTitle: true,
  flexibleSpace: TITLE(),
 ),  
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OnMonthlyBasis:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 2.0,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      incomeInputField(
                        label: 'Enter Name',
                        controller: _name,
                        hint: 'Your Name',
                        keyboardType: TextInputType.text,
                      ),
                      incomeInputField(
                        label: 'Enter Occupation',
                        controller: _occupation,
                        hint: 'Your Occupation',
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      incomeInputField(
                        label: 'Enter Amount',
                        controller: _InAmount,
                        hint: 'Your Income Amount',
                        keyboardType: TextInputType.number,
                      ),
                      MonthDropdownInputField(label: 'selectDate', controller: _months,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0, top: 5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 40),
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          elevation: 10.0,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          datacollection(
                            _name.text,
                            _occupation.text,
                            _InAmount.text,
                            _months.text,
                          );  
                          _name.clear();
                          _occupation.clear();
                          _InAmount.clear();
                          _months.clear();
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // DailyBasis section
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OnDailyBasis:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 2.0,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      incomeInputField(
                        label: 'Enter Name',
                        controller: _name1,
                        hint: 'Your Name',
                        keyboardType: TextInputType.text,
                      ),
                      incomeInputField(
                        label: 'Enter Occupation',
                        controller: _occupation1,
                        hint: 'Your Occupation',
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      incomeInputField(
                        label: 'Daily Inc.amount',
                        controller: _InAmount1,
                        hint: 'Daily Amount',
                        keyboardType: TextInputType.number,
                      ),
                 MonthDropdownInputField(label: 'selectDate', controller: _months1,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0, top: 5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 40),
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          elevation: 10.0,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          datacollection(_name1.text, _occupation1.text, _InAmount1.text, _months1.text);
                          print(MonthlyBasis);
                          _name1.clear();
                          _occupation1.clear();
                          _InAmount1.clear();
                          _months1.clear();
                          // Handle DailyBasis data collection here
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void datacollection(String name, String occupation, String InAmount, String months) {
    setState(() {
      if (name.isNotEmpty && occupation.isNotEmpty && InAmount.isNotEmpty && months.isNotEmpty) {
        MonthlyBasis = {
          "NAME": name,
          "OCCU": occupation,
          "INCOME": int.tryParse(InAmount) ?? 0,
          "MONTHS": months
        };
       firebaseservice.addIncomeData(MonthlyBasis).then((_) {
        // After data is added, show dialog
      Showdialog.ShowAlert(context,alertTitle);
      }).catchError((error) {
        print('Failed to add data: $error');
        final snackbar = SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }); 
      } 
      else {
        Snackbar.showSnackBar(context,snackBarContent);

      }
    });  
  }
}
