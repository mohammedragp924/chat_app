import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class CustomFormTextFiled extends StatelessWidget {
  CustomFormTextFiled(
      {super.key, this.hintText, this.onChanged, this.obsecureText = false});
  Function(String)? onChanged;
  String? hintText;
  bool? obsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return ("Filed is required!");
        }
        return null;
      },
      autocorrect: true,
      enableSuggestions: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
