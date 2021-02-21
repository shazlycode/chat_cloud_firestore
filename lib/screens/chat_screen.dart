import 'package:chat_cloud_firestore/widgets/messages.dart';
import 'package:chat_cloud_firestore/widgets/send_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            onChanged: (value) async {
              if (value == 'exit') {
                await FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'exit',
                child: Row(
                  children: [Text('Exit'), Icon(Icons.exit_to_app)],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          SendMessage(),
        ],
      ),
      //
    );
  }
}
