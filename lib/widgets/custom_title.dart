import 'package:flutter/material.dart';

Row titleMethod() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image(
        height: 40,
        image: AssetImage('assets/images/scholar.png'),
      ),
      Text(
        'chat',
        style: TextStyle(color: Colors.white),
      ),
    ],
  );
}
