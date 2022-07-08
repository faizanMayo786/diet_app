import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  var user;
  @protected
  @mustCallSuper
  @override
  void initState() {
    getUid();
  }

  getUid() async {
    user = FirebaseAuth.instance.currentUser!.uid;
    print('User :' + FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    getUid();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
