import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  var msgText = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance
        .collection('chat')
        .add({'text': msgText, 'createdAt': Timestamp.now()});
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                msgText = value;
              });
            },
            decoration: InputDecoration(
                labelText: 'Send a new message...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: msgText.trim().isEmpty
                ? null
                : () {
                    _sendMessage();
                  },
          )
        ],
      ),
    );
  }
}
