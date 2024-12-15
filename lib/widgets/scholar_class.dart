import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/pages/register_page.dart';

class ScholarApp extends StatelessWidget {
  const ScholarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        ChatPage.id: (context) => const ChatPage(),
      },
      initialRoute: LoginPage.id,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
