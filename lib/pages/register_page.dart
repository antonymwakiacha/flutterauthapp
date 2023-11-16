// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthapp/components/my_button.dart';
import 'package:flutterauthapp/components/my_textfield.dart';
import 'package:flutterauthapp/components/square_tile.dart';
import 'package:flutterauthapp/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({required this.onTap, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _agecontroller = TextEditingController();

  //sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try creating the user
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        //add user details
        addUserDetails(
          _firstnamecontroller.text.trim(),
          _lastnamecontroller.text.trim(),
          emailController.text.trim(),
          int.parse(_agecontroller.text.trim()),
        );
      } else {
        //password do not match
        showErrorMessage("Passwords do not match");
      }

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

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
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
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
    _agecontroller.dispose();

    super.dispose();
  }

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
                  size: 50,
                ),

                const SizedBox(
                  height: 50,
                ),

                //welcome back,you have been missed
                Text(
                  'Let\'s create an Acount!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //first name textfield
                MyTextField(
                  controller: _firstnamecontroller,
                  hintText: 'First Name',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 25,
                ),
                //last name textfield
                MyTextField(
                  controller: _lastnamecontroller,
                  hintText: 'Last Name',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 25,
                ),
                //age textfield
                MyTextField(
                  controller: _agecontroller,
                  hintText: 'Age',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 25,
                ),
                //username textfield
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

                //confirm password
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                // const SizedBox(
                //   height: 25,
                // ),

                // //forgot password?
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text("Forgot Password?",
                //           style: TextStyle(
                //             color: Colors.grey[600],
                //           )),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 25,
                ),

                //sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
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
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now",
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
