// ignore: unused_import
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
// ignore: unused_import
import 'package:flutter_application_1/views/profile_page.dart';
import 'package:http/http.dart' as http;

Future<void> DirectoryMethod(String username, String password, BuildContext context) async {
  var response = await http.post(
    Uri.parse('https://serverscale.herokuapp.com/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{"username": username, "password": password}),
  );

  if (response.statusCode == 200) {
    if (response.body=="authentication error: try again"){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Incorrect username or password."),
            ));

    }
    else {
      print(jsonDecode(response.body));
      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(profile : Profile.fromJson(jsonDecode(response.body)))),
                );
    }
    // If the server did return a 200 response,
    // then parse the JSON.
  } else {
    // If the server did not return a 200 response,
    // then throw an exception.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error : unable to connect to server"),
            ));
  }
}


class DirectoryPage extends StatelessWidget {
  final List<Profile> directory;
  static const routeName = '/directory-page';

  const DirectoryPage({Key? key, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annuaire"),
      ),
      body: ListView.builder(
          itemCount: directory.length,
          itemBuilder: (BuildContext context, int position) {
            Profile item = directory.elementAt(position);
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(profile: item)),
                );
              },
              title: Text("${item.firstName} ${item.lastName}"),
            );
          }),
    );
  }
}
