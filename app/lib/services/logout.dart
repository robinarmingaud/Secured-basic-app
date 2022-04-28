import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:http/http.dart' as http;


Future<void> LogoutMethod(BuildContext context) async {
  Navigator.pushReplacement(context, MaterialPageRoute(builder :(context) => const LoginPage()));
  await http.get(
    Uri.parse('https://serverscale.herokuapp.com/logout'),
    headers: <String, String>{}
  );
}