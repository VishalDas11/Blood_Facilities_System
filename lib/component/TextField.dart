
import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  Field({Key? key,
    required this.hintText,
    required this.label,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obsecure = false,

  }) : super(key: key);

  final String hintText;
  final String label;
  final prefixIcon ;
  final suffixIcon;
  final bool obsecure;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ,
      obscureText: obsecure,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, ),
          hintText: hintText,
          label: Text(label),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide()
          )
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Please Fill this Field";
        }
        return null;
      },
    );


  }
}