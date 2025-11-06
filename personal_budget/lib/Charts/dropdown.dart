import 'package:flutter/material.dart';

class ChartMonth extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>onChanged;

  const ChartMonth({super.key, 
    required this.label,
    required this.controller,
    required this.onChanged
  });

  @override
  _MonthDropdownInputFieldState createState() =>_MonthDropdownInputFieldState();
}

class _MonthDropdownInputFieldState extends State<ChartMonth> {
  // List of months
  List<String> allMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  late String selectItem;
  @override
   void initState() {
        super.initState();
    selectItem=widget.controller.text.isNotEmpty ? widget.controller.text:"Jan";
    widget.controller.text=selectItem;
  }
  @override
  Widget build(BuildContext context){
    return     Card(
              color:Colors.white,
              elevation: 7.0,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(padding:EdgeInsets.only(top: 5),
            child:SizedBox(
                width: MediaQuery.of(context).size.width* 0.45,
                child:Column(
                  children: [
               DropdownButton<String>(
  value: selectItem,
  items: allMonths.map((String item) {
    return DropdownMenuItem(
      value: item,  
      child: Text(item), 
    );
  }).toList(), 
  onChanged: (String? newValue) { 
    setState(() {
      selectItem = newValue!;
      widget.controller.text=newValue;
          widget.onChanged(newValue);
    });
  },
)

                  ],
                ) ,
              ),
              ),
            );
  }
}
