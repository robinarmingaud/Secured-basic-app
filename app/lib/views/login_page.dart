import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/directory_page.dart';
import 'package:http/http.dart' as http;

Future<void> LoginMethod(String username, String password) async {
  var response = await http.post(
    Uri.parse('https://serverscale.herokuapp.com/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{"username": username, "password": password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    print(Album.fromJson(jsonDecode(response.body)[0]));
  } else {
    // If the server did not return a 200 response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String firstname;
  final String lastname;
  final String picture;
  final String biography;

  const Album({required this.firstname, required this.lastname, required this.picture, required this.biography});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      firstname: json['firstname'],
      lastname: json['lastname'],
      picture: json['picture'],
      biography: json['biography'],
    );
  }
}

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String pseudo;
  late String password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    pseudo = value;
                  });
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Pseudo *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.key),
                  labelText: 'Password *',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      LoginMethod(pseudo, password);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
