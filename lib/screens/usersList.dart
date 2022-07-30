import 'package:chat/models/users.dart';
import 'package:chat/screens/searchUser.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Baatein"), actions:
      [IconButton(onPressed:(){
        Navigator.of(context).pushNamed(SearchUser.route);
      } , icon: Icon(Icons.search)) ,]),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('users').snapshots(),
        initialData: null,
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.hasError){
            return Center(child:Text("Error"));
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting : return Center(child:CircularProgressIndicator());
            default : {
              List<Users> _users=Database().getUserFromDb(snapshot.data);
              return Container(
                  child:ListView.builder(
                    itemCount:_users.length,
                      itemBuilder: (BuildContext ctx,int index){
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(_users[index].imageUrl!),),
                          title: Text(_users[index].userName!),
                        );
                      }));
            }
          }


        }
      ),
    );
  }
}
