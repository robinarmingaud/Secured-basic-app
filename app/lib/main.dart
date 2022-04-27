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
        DirectoryPage.routeName: (context) => const DirectoryPage(directory: [
              Profile(
                  "Brad",
                  "Pitt",
                  "https://media.gqmagazine.fr/photos/6082bd46e24bc2c55a7e1c4f/1:1/w_120",
                  "William Bradley Pitt (born December 18, 1963) is an American actor and film producer."),
              Profile(
                  "Georges",
                  "Clooney",
                  "https://fr.web.img6.acsta.net/pictures/16/05/12/17/04/136865.jpg",
                  "George Timothy Clooney (born May 6, 1961) is an American actor and filmmaker. He is the recipient of numerous accolades, including a British Academy Film Award, four Golden Globe Awards, and two Academy Awards, one for his acting and the other as a producer."),
            ])
      },
      home: LoginPage(),
    );
  }
}
