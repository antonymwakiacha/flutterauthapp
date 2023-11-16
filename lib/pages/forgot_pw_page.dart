// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthapp/components/my_button.dart';
import 'package:flutterauthapp/components/my_textfield.dart';

class FogortPasswordPage extends StatefulWidget {
  const FogortPasswordPage({super.key});

  @override
  State<FogortPasswordPage> createState() => _FogortPasswordPageState();
}

class _FogortPasswordPageState extends State<FogortPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link sent.Check your email."),
            );
          });
    } on FirebaseAuthException catch (e) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter your email and we will send you a reset password link",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyTextField(
            controller: _emailController,
            hintText: 'Email',
            obscureText: false,
          ),
          SizedBox(
            height: 10,
          ),
          MyButton(
            onTap: resetPassword,
            text: "Reset Password",
          ),
        ],
      ),
    );
  }
}
