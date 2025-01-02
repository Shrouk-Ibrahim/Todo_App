import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyBoardType ;
  TextEditingController controller ;
  String? Function(String?)  validator ;
  bool isPassword ;

  CustomTextFormField({required this.label,this.keyBoardType=TextInputType.text
  ,required this.controller,required this.validator,
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
            label: Text(label),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
                  width: 3,
          )
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              )
          ),

        ),
        keyboardType:keyBoardType ,
        controller: controller,
        validator: validator ,
        obscureText:isPassword ,

      ),
    );
  }
}
