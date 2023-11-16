// ignore_for_file: prefer_const_constructors

//import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthapp/read%20data/get_user_name.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  //document IDs
  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  // @override
  // void initState() {
  //   getDocId();
  //   super.initState();
  // }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            user!.email!,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "LOGGED IN AS : " + user!.email!,
            //   style: TextStyle(
            //     fontSize: 20,
            //   ),
            // ),
            SizedBox(
              height: 10.0,
            ),
            // MaterialButton(
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut();
            //   },
            //   color: Colors.black,
            //   child: Text("Sign Out",
            //       style: TextStyle(
            //         color: Colors.white,
            //       )),
            // ),
            Expanded(
                child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: GetUserName(documentId: docIDs[index]),
                          tileColor: Colors.grey,
                        ),
                      );
                    }));
              },
            )),
          ],
        ),
      ),
    );
  }
}
