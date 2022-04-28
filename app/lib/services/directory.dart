import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/views/directory_page.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:http/http.dart' as http;

Future<void> DirectoryMethod(BuildContext context) async {
  var response = await http.get(
    Uri.parse('https://serverscale.herokuapp.com/directory_page'),
    headers: <String, String>{}
  );
  var resp = jsonDecode(response.body);
  List<Profile> list = <Profile>[];
  for (var item in resp){
    list.add(Profile(item['firstname'], item['lastname'] , 'secret', 'secret'));
  }
  Navigator.push(context, MaterialPageRoute(builder :(context) => DirectoryPage(directory : list)));
}