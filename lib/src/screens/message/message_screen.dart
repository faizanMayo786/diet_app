import 'package:flutter/material.dart';

import '../../widget/message.dart';
import '../../widget/new_message.dart';

// ignore: must_be_immutable
class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key, required this.user}) : super(key: key);
  String user;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Messages(user: widget.user)),
        NewMessage(user:widget. user),
      ],
    );
  }
}
