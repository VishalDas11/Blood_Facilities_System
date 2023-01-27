import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown({Key? key, this.controller, required this.hinttext}) : super(key: key);

  final controller;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      controller: controller ,
      dropDownList: const [
        DropDownValueModel(name: 'A+', value: 'A+'),
        DropDownValueModel(name: 'A-', value: 'A-'),
        DropDownValueModel(name: 'B+', value: 'B+'),
        DropDownValueModel(name: 'B-', value: 'A-'),
        DropDownValueModel(name: 'O+', value: 'O+'),
        DropDownValueModel(name: 'O-', value: 'O-'),
        DropDownValueModel(name: 'AB+', value: 'AB+'),
        DropDownValueModel(name: 'AB-', value: 'AB-'),
      ],
      textFieldDecoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          hintText: hinttext,
          label: const Text("Blood Group"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Please select Blood Group";
        }
        return null;
      },
    );
  }
}