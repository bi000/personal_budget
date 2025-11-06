import 'package:flutter/material.dart';
class incomeDropDownField extends StatefulWidget{
  final String label;
  final TextEditingController controller;
  const incomeDropDownField({super.key, required this.label, required this.controller,});
  @override
  _itemList createState()=>_itemList();

}
class _itemList extends State<incomeDropDownField>{
  List<String>allItems=["Food","Clothes","Entertainment","Gadgets","Special Occasion","Utilities"];
  late String selectItem;
  @override
  void initState() {
    selectItem=widget.controller.text.isNotEmpty ? widget.controller.text:"Food";
    widget.controller.text=selectItem;
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return     Card(
              color:Colors.white,
              elevation: 4.0,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(padding:EdgeInsets.only(top: 5),
            child:SizedBox(
                width: MediaQuery.of(context).size.width* 0.45,
                child:Column(
                  children: [
               DropdownButton<String>(
  value: selectItem,
  items: allItems.map((String item) {
    return DropdownMenuItem(
      value: item,  
      child: Text(item), 
    );
  }).toList(), 
  onChanged: (String? newValue) { 
    setState(() {
      selectItem = newValue!;
      widget.controller.text=newValue;
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