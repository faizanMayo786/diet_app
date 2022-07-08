import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/message.dart';
import '../../widget/new_message.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key, required this.user}) : super(key: key);
  String user;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(child: Messages(user: widget.user)),
          NewMessage(user:widget. user),
        ],
      ),
    );
  }
}
