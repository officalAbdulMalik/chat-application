class MessageModel {
  final String message;
  final String senderId;
  final String recieverId;
  final String date;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.recieverId,
    required this.date,
  });

  static MessageModel fromJson(Map<String, dynamic> map) {
    return MessageModel(
        message: map['message'],
        senderId: map['senderId'],
        recieverId: map['recieverId'],
        date: map['timeStamp']);
  }
}
