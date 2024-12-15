import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/widgets/custom_text_filed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formkey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Image.asset("assets/Images/scholar.png"),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'pacifico',
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                CustomFormTextFiled(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomFormTextFiled(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        // ignore: unused_local_variable
                        await registerMethod();
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (exeption) {
                        if (exeption.code == 'week-password') {
                          showSnackBar(
                              context: context,
                              message: 'password is too weak.',
                              color: Colors.amber);
                        } else if (exeption.code == 'email-already-in-use') {
                          showSnackBar(
                              context: context,
                              message: 'email already exists.',
                              color: Colors.red);
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'REGESTER',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerMethod() async {
    // UserCredential user = await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
