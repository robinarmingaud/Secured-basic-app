// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/views/profile_page.dart';

import 'views/directory_page.dart';
import 'views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppScale',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
      },
      home: LoginPage(),
    );
  }
}

