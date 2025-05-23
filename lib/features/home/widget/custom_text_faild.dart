import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';

class CustomTextfaild extends StatelessWidget {
 const CustomTextfaild(
      {super.key,
      this.hintText,
      required this.controller,
      this.maxLines,
      this.validator});
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 20,color: Colors.black),
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),),
            focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),),
          hintText: hintText,
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle:const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 15)),
    );
  }
}