import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/controlers/helper_class.dart';
import 'package:online_shop/views/utils/custom_tile.dart';
import '../controlers/add_message_repo.dart';
import '../controlers/chats.dart';
import '../controlers/firestore_repo.dart';

// ignore: camel_case_types
class chat extends StatefulWidget {
  final String cid;
  final String username; //current user
  const chat({Key? key, required this.cid, required this.username})
      : super(key: key);

  @override
  State<chat> createState() => _chatState(this.cid, this.username);
}

// ignore: camel_case_types
class _chatState extends State<chat> {
  String cid;
  String username;
  _chatState(this.cid, this.username);
  TextEditingController messageeditingcontroller = TextEditingController();
  var chats;
  List data = [];
  @override
  void initState() {
    FirestoreRepo().getChats(cid).then((val) {
      setState(() {
        chats = val;
        //print(chats.length.toString())
      });
    });
    super.initState();
  }

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
                controller: messageeditingcontroller,
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
                  await AddMessageRepo().addMessage(
                      messageeditingcontroller: messageeditingcontroller.text,
                      username: username,
                      cid: cid);
                  messageeditingcontroller.text = '';
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
                stream: chats,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return snapshot.hasData
                      ? ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return MessageTile(
                              message: snapshot.data!.docs[index]["message"],
                              sendByMe: username ==
                                  snapshot.data!.docs[index]["sendBy"],
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
