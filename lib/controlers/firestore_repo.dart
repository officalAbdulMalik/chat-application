import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepo {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<int> createUser({required String users}) async {
    try {
      final user = firestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': users,
      });
      return 200;
    } catch (e) {
      return 400;
    }
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    return FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .collection("chat")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .collection("chat")
        .orderBy('time')
        .snapshots();
  }
}
