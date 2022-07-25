// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewMessage extends StatefulWidget {
  NewMessage({
    Key? key,
    required this.user,
  }) : super(key: key);
  String user;
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!.uid;
    final username =
        await FirebaseFirestore.instance.collection('admin').doc(user).get();
    FirebaseFirestore.instance.collection('chat/${widget.user}/message/').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user,
        'username': username['username'],
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                enabledBorder:  UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.send,
            ),
          )
        ],
      ),
    );
  }
}
