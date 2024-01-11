import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/controlers/helper_class.dart';

import '../views/utils/custom_tile.dart';

class GitChat extends StatelessWidget {
  final String cid;
  final String username;
  Stream<QuerySnapshot>? chats;
  GitChat(
      {Key? key,
      required this.cid,
      required this.username,
      required this.chats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: Helper.scrollController,
                reverse: true,
                primary: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index]["message"],
                    sendByMe: username == snapshot.data!.docs[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }
}
