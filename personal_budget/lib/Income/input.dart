import 'package:flutter/material.dart';
class incomeInputField extends StatelessWidget{
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  const incomeInputField({super.key, required this.label, required this.controller,required this.hint,required this.keyboardType});
  @override
  Widget build(BuildContext context){
    return     Card(
              color:Colors.white,
              elevation: 4.0,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: SizedBox(
                width: MediaQuery.of(context).size.width* 0.45,
                child:Column(
                  children: [
                    TextField(
                      controller:controller,
                      decoration: InputDecoration(
                        labelText: label,
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        hintText: hint,
                        labelStyle: TextStyle(color: Colors.black),
                         border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 2.0),
                                borderRadius: BorderRadius.zero,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 1.0),
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple, width: 2.0),
                                borderRadius: BorderRadius.zero,
                              ),
                              alignLabelWithHint: true,
                      ),
                      keyboardType: keyboardType,
                      textAlign: TextAlign.start,
                    )
                  ],
                ) ,
              ),
            );
  }
}