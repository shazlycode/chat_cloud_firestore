import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String imageUrl;
  MessageBubble(this.message, this.isMe, this.username, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            width: 250,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isMe ? Colors.pink : Colors.deepPurple,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            )),
      ],
    );
  }
}
