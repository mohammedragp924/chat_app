import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';
// ignore_for_file: camel_case_types

class chatBuble extends StatelessWidget {
  const chatBuble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
              bottomRight: Radius.circular(28),
            )),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class chatBubleForFriend extends StatelessWidget {
  const chatBubleForFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
              bottomLeft: Radius.circular(28),
            )),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
