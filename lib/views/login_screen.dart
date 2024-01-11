import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/views/sign_up_screen.dart';
import 'package:online_shop/views/users_page.dart';
import 'package:online_shop/views/utils/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController mail = TextEditingController();
TextEditingController password = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20),
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Login User'),
            SizedBox(
              height: 20,
            ),
            MyTextFields(
              errorMessage: 'fill the Foam',
              hint: 'Email',
              icon: Icons.mail,
              controller: mail,
            ),
            SizedBox(
              height: 20,
            ),
            MyTextFields(
              errorMessage: 'fill the Foam',
              hint: 'password',
              icon: Icons.lock,
              controller: password,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: mail.text, password: password.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UserPages(
                    mail: mail.text,
                  );
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(flex: 2, child: Text('if you have no  account')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpScreen();
                        }));
                      },
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
