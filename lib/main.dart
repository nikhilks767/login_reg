// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_reg/controller/home_screen_controller.dart';
import 'package:login_reg/view/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLDatabase.initializeDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
