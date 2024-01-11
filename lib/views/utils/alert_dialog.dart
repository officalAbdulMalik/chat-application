import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controlers/text_controler.dart';
import '../groups_screen.dart';
import '../users_page.dart';

class AlertDialogs extends StatelessWidget {
  AlertDialogs({
    Key? key,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        height: 300,
        width: 250,
        color: Colors.white,
        child: Column(
          children: [
            const Expanded(
                flex: 2,
                child: Center(child: Text('Please Enter Your Group Name'))),
            Expanded(
                child: SizedBox(
              height: 60,
              width: 300,
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: 'enter group name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    ))),
              ),
            )),
            const Expanded(child: SizedBox()),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('groups')
                        .doc(controller.text)
                        .set({
                      'name': controller.text.trim(),
                      'users': users,
                    });
                    users.clear();
                    print(users);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GroupsScreen(
                        users: users,
                      );
                    }));
                    controller.text = '';
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    height: 30.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      color: Colors.red,
                    ),
                    child: Center(
                        child: Text(
                      'Next',
                      style: TextStyle(color: Colors.black, fontSize: 30.sp),
                    )),
                  ),
                )),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
