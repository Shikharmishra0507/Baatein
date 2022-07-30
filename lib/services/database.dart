import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';
class Database{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  User? user=FirebaseAuth.instance.currentUser;
  Future<void> uploadUserData(String username,String email)async{
    String imageUrl = await
    firebase_storage.FirebaseStorage.instance
        .ref('user_images').child(user!.uid)
        .getDownloadURL();
    await firestore.collection('users').doc(user!.uid).set({
      'username':username,
      'email':email,
      'imageUrl':imageUrl,
      'uid':user!.uid
    });
  }
  List<Users> getUserFromDb (QuerySnapshot querySnapshot){
    List<QueryDocumentSnapshot> documents=querySnapshot.docs;
    List<Users> users=[];
    for(int i=0;i<documents.length;i++){
      Map<String,dynamic>data=documents[i].data() as Map<String,dynamic>;
      users.add(Users.fromJson(data));
    }

    return users;
  }
}