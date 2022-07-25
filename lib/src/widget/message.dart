// ignore_for_file: override_on_non_overriding_member, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key, required this.user}) : super(key: key);
  String user;
  @protected
  @mustCallSuper
  @override
  void initState() {
    getUid();
  }

  getUid() async {}

  @override
  Widget build(BuildContext context) {
    getUid();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat/$user/message/')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapShotChat) {
        if (snapShotChat.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapShotChat.hasData) {
            return ListView.builder(
              reverse: true,
              itemCount: snapShotChat.data!.docs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                snapShotChat.data!.docs[index]['text'],
                snapShotChat.data!.docs[index]['userId'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                snapShotChat.data!.docs[index]['username'],
                key: ValueKey(snapShotChat.data!.docs[index].id),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
