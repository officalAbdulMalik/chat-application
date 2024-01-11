import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/controlers/firebase_cubit/firebase_cubit.dart';
import 'package:online_shop/views/users_page.dart';
import 'package:online_shop/views/utils/custom_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../controlers/firestore_repo.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('Enter Email and Password'),
            const SizedBox(
              height: 20,
            ),
            MyTextFields(
              errorMessage: 'Please Fill The Form',
              hint: 'Email',
              icon: Icons.person,
              isPasswordField: false,
              controller: user,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextFields(
              errorMessage: 'Please Fill The Form',
              hint: 'Password',
              icon: Icons.lock,
              isPasswordField: false,
              controller: pass,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<FirebaseCubit, FirebaseState>(
              listener: (context, state) {
                if (state is FirebaseLoaded) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (user.text.isEmpty && pass.text.isEmpty) {
                      print('fill text field');
                    } else {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: user.text, password: pass.text);
                      context.read<FirebaseCubit>().addUser(users: user.text);
                    }
                  },
                  child: BlocBuilder<FirebaseCubit, FirebaseState>(
                    builder: (context, state) {
                      if (state is FirebaseLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is FirebaseLoaded) {
                        return Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      } else if (state is FirebaseError) {
                        return const Text('Error');
                      } else {
                        return Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
