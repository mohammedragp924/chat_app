import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/widgets/custom_text_filed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

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
                      'LOGIN',
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
                  obsecureText: true,
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
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (exeption) {
                        if (exeption.code != exeption.plugin) {
                          showSnackBar(
                              context: context,
                              message: 'email or password is wrong!',
                              color: Colors.red);
                        } else {
                          // print(exeption);
                          showSnackBar(
                              context: context,
                              message: 'there was an error',
                              color: Colors.red);
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'LOGIN',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'REGISTER',
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

  Future<void> loginUser() async {
    // UserCredential user = await FirebaseAuth.instance
    //     .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
