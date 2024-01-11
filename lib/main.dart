import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/controlers/firebase_cubit/add_user_group_cubit.dart';
import 'package:online_shop/controlers/firebase_cubit/firebase_cubit.dart';
import 'package:online_shop/views/login_screen.dart';
import 'package:online_shop/views/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FirebaseCubit(),
              ),
              BlocProvider(
                create: (context) => AddUserCubit(false),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginScreen(),
            ),
          );
        });
  }
}
