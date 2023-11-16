// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthapp/components/my_button.dart';
import 'package:flutterauthapp/components/my_textfield.dart';
import 'package:flutterauthapp/components/square_tile.dart';
import 'package:flutterauthapp/pages/forgot_pw_page.dart';
import 'package:flutterauthapp/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({required this.onTap, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple,
            title: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //wromg email message pop up
  // void wrongEmailMessage() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Incorrect Email.'),
  //         );
  //       });
  // }

  // //wromg password message pop up
  // void wrongPasswordMessage() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Incorrect Password.'),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                //welcome back,you have been missed
                Text(
                  'Welcome back,its beeen a while.',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 25,
                ),
                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25,
                ),

                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return FogortPasswordPage();
                          }));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //sign in button
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),

                const SizedBox(
                  height: 50,
                ),

                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 52.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Or Continue With'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                //google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png',
                    ),

                    const SizedBox(
                      width: 25,
                    ),
                    //apple button
                    SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
