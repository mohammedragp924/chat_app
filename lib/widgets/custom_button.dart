import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.onTap,
    required this.text,
  });
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 40,
        width: double.infinity,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
