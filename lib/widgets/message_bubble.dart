import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  bool isCurrentUser;
  String imageUrl;
  final Key key;
  MessageBubble(this.message , this.username ,this.isCurrentUser,this.imageUrl ,{required this.key});

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    double bubbleMaxLength=MediaQuery.of(context).size.width*0.4;
    return Stack(
      children:[Align(
        alignment: isCurrentUser ?Alignment.bottomRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: 140,
          constraints: BoxConstraints(
              maxWidth: bubbleMaxLength
          ),
          decoration: BoxDecoration(
            color: isCurrentUser? Colors.teal : Colors.purple,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                isCurrentUser ? 0 : 12,
              ),
              topLeft: Radius.circular(
                isCurrentUser ? 12 : 0,
              ),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),

          ),
          child: Column(
            crossAxisAlignment: isCurrentUser ?CrossAxisAlignment.end  : CrossAxisAlignment.start,
            children: [
              Text(username ,style:TextStyle(fontWeight: FontWeight.bold), ),
              Text(
                message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.yellow : Colors.black,
                ),
                textAlign: isCurrentUser? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ),
        Positioned(

          left:isCurrentUser?null : 130,
          right:isCurrentUser?  130 : null,
          child: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),)
      ]

    );
  }
}
