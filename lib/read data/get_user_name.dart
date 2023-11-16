// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the users
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('${data['first name']}' +
                ' ' +
                '${data['last name']}' +
                ',  ' +
                '${data['age']}' +
                ' ' +
                'years old');
          }
          return Text('loading...');
        }));
  }
}
