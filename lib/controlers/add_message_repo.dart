import 'firestore_repo.dart';

class AddMessageRepo {
  Future addMessage(
      {required String messageeditingcontroller,
      required String username,
      required String cid}) async {
    if (messageeditingcontroller.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": username,
        "message": messageeditingcontroller,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      FirestoreRepo().addMessage(cid, chatMessageMap);
    }
  }
}
