import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../text_controler.dart';

class AddMessageGroup {
  //create message
  Future addMessage({
    required String messageeditingcontroller,
    required String gropName,
  }) async {
    if (messageeditingcontroller.isNotEmpty) {
      String username = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic> chatMessageMap = {
        "sendBy": username,
        "message": messageeditingcontroller,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      message(
        chatMessageMap,
        gropName,
      );
    }
  }

//add message data to group
  Future<void> message(chatMessageData, groupName) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(groupName)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

//get group messages
  getChats(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection("groups")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }
}
