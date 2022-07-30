import 'package:chat/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Messages extends StatelessWidget {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  User ?user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore.collection('chat').orderBy('createdAt',descending: true).snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.hasError){
        return Center(child:Text("Something went wrong"));
      }
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child:CircularProgressIndicator());
        default:{
          List<QueryDocumentSnapshot>? chatDocs=snapshot.data?.docs;
          return  chatDocs==null ? Center(child:Text("Start Conversation by saying Hi")) :
          ListView.builder(

            reverse: true,
            itemBuilder: (ctx,index){

            final documentSnapshot=chatDocs[index];
            Map<String,dynamic>data=documentSnapshot.data() as Map<String,dynamic>;



            return  MessageBubble(data['Text'],data['username'] ,
                  data['uid'] == user!.uid,data['imageUrl'],key: ValueKey(chatDocs[index].id),);
          },itemCount:chatDocs.length ,);
        }
      }


    }) ,
      );
  }
}
