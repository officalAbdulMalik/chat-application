import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: sendByMe
              ? const EdgeInsets.only(left: 30)
              : const EdgeInsets.only(right: 30),
          padding:
              const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe
                    ? [Colors.green, Colors.orange]
                    : [const Color(0xff000000), const Color(0xff999999)],
              )),
          child: Text(message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
