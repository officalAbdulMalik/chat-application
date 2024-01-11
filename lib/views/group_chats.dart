import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/views/utils/custom_tile.dart';

import '../controlers/add_message_repo.dart';
import '../controlers/group_data/send_message.dart';

class GroupChats extends StatefulWidget {
  String groupName;

  GroupChats({Key? key, required this.groupName}) : super(key: key);

  @override
  State<GroupChats> createState() => _GroupChatsState();
}

class _GroupChatsState extends State<GroupChats> {
  var chat;
  @override
  void initState() {
    chat = AddMessageGroup().getChats(widget.groupName);

    // TODO: implement initState
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  String user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          color: Colors.green,
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Message ...",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    border: InputBorder.none),
              )),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () async {
                  AddMessageGroup().addMessage(
                      messageeditingcontroller: controller.text,
                      gropName: widget.groupName);
                  controller.text = '';
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Conversation Screen "),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 5,
            bottom: 0,
            child: SizedBox(
              height: 550,
              width: 400,
              child: StreamBuilder(
                stream: chat,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return MessageTile(
                              message: snapshot.data!.docs[index]["message"],
                              sendByMe:
                                  user == snapshot.data!.docs[index]['sendBy'],
                            );
                          })
                      : Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
