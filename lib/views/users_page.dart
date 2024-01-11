import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/views/utils/alert_dialog.dart';

import '../controlers/crete_chats.dart';
import '../controlers/firebase_cubit/add_user_group_cubit.dart';
import '../controlers/helper_class.dart';
import '../controlers/text_controler.dart';
import 'chats_scree.dart';
import 'groups_screen.dart';

class UserPages extends StatefulWidget {
  String mail;

  UserPages({Key? key, required this.mail}) : super(key: key);

  @override
  State<UserPages> createState() => _UserPagesState();
}

TextEditingController controller = TextEditingController();

List users = [];

bool userAdd = false;

String uid = FirebaseAuth.instance.currentUser!.uid;

class _UserPagesState extends State<UserPages> {
  @override
  Widget build(BuildContext context) {
    print('============================');
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GroupsScreen(
                    users: users,
                  );
                }));
              },
              child: const Icon(
                Icons.group,
                size: 30,
              ),
            ),
          )
        ],
        title: const Text('Users'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var curent = snapshot.data!.docs[index]['email'];
                  var user = widget.mail;
                  return curent == user
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return chat(
                                cid: Helper.getChatRoomId(curent, user),
                                username: curent,
                              );
                            }));
                          },
                          child: Card(
                            child: ListTile(
                              leading: Text(
                                snapshot.data!.docs[index]['email'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  if (!users.contains(curent)) {
                                    users.add(uid);
                                    if (users.length == 2) {
                                      context
                                          .read<AddUserCubit>()
                                          .userAdded(index: true);
                                      print(">>>>>>>>>>.${users.toString()}");
                                    }
                                  }
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        );
                });
          } else {
            print(snapshot.data!.docs.toString());
            return const Center(child: Text('Something else'));
          }
        },
      ),
      floatingActionButton: BlocBuilder<AddUserCubit, bool>(
        builder: (context, state) {
          return Visibility(
            visible: state == true ? true : false,
            child: FloatingActionButton(
              backgroundColor: Colors.cyan,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogs();
                    });
                context.read<AddUserCubit>().userAdded(index: false);
              },
              child: const Icon(
                Icons.group,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
