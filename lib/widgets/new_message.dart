import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController _textController=new TextEditingController();
  final auth=FirebaseAuth.instance.currentUser;
  @override
  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection('users').doc(auth!.uid).get();
    Map<String,dynamic>? data=snapshot.data() as Map<String,dynamic>;
    if(data==null)return ;
    FirebaseFirestore.instance.collection('chat').add({
      'Text':writtenMessage,
      'createdAt':Timestamp.now(),
      'uid':auth==null? null :auth!.uid,
      'username':data['username'],
      'imageUrl':data['imageUrl']
    });
    _textController.clear();
  }
  var writtenMessage='';
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
     child: Row(children: [
       Expanded(child: TextFormField
         (controller: _textController,
         decoration: InputDecoration(labelText: 'Message'),
          onChanged: (value){
           setState(() {
             writtenMessage=value;
           });

          },
       )),
       IconButton(onPressed: writtenMessage.trim().isEmpty ? null : (){
         _sendMessage();
       }, icon: Icon(Icons.send))
     ],)
    );
  }
}
