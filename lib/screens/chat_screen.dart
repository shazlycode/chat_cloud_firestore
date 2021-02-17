import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/ejrVVbooGsLszZ1xfvHe/messages')
                .add({'text': 'hello'});
          },
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/ejrVVbooGsLszZ1xfvHe/messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) =>
                      Text(snapshot.data.docs[index]['text']));
            }
          },
        )
        //
        );
  }
}
