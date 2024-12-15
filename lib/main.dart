import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/widgets/scholar_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarApp());
}
