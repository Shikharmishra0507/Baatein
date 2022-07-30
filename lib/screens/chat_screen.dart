
import 'package:chat/services/authentication.dart';
import 'package:chat/services/database.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/messages.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String ?dropDownValue="logout";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          DropdownButton(
            icon: Icon(Icons.more_vert),
              items: [
            DropdownMenuItem(value: "logout",child:Row(children: [
              Icon(Icons.logout), Text("logout")
            ],))
          ], onChanged: (String ?value) async{
            setState(() {
              dropDownValue=value;
            });
            if(value=='logout'){
              await Authentication().signOut();
            }
          })

        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   FirebaseFirestore.instance.collection
      //     ("chats/g8xLFc6LvAGOWaChyjqM/messages").add({
      //     'Text':"New Entry"
      //   });
      //
      // }, child:Icon(Icons.add)),
      body:
         Container(child: Column(
           children: [
             Expanded(child: Messages()),
             NewMessage()
           ],
         ))
      
    );
  }
}
