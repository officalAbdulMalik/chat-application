import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChats {
  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    //chatroom is a map[string ,array or dynamic]
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }
}
