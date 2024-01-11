import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/views/group_chats.dart';
import 'package:online_shop/views/users_page.dart';

class GroupsScreen extends StatefulWidget {
  List users;

  GroupsScreen({Key? key, required this.users}) : super(key: key);

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

String cureentUser = FirebaseAuth.instance.currentUser!.uid;
bool userAvilable = true;

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .where('users', arrayContains: cureentUser)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return GroupChats(
                            groupName: snapshot.data!.docs[index].id,
                          );
                        }));
                      },
                      child: Visibility(
                        visible: true,
                        child: ListTile(
                          title: Text(snapshot.data!.docs[index].id),
                          trailing: const Icon(Icons.group),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: Text('no data'));
            }
          }),
    );
  }
}
