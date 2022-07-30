import 'package:chat/services/authentication.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../services/database.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void submitDetails(String email, String password, String userName,
      File? image, bool isLogin) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      if (isLogin) {
        await Authentication().signInWithEmail(email, password);
      } else {
        await Authentication().signupWithEmail(email, password);
        user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception("Null");
        await firebase_storage.FirebaseStorage.instance
            .ref('user_images/')
            .child(user.uid)
            .putFile(image!);
        await Database().uploadUserData(userName, email);
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Something went wrong"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Okay"))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: AuthForm(submitDetails),
    );
  }
}
