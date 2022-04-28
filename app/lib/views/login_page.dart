import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/services/secure.dart';
import 'package:flutter_application_1/views/directory_page.dart';
import 'package:flutter_application_1/views/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:ssl_pinning_plugin/ssl_pinning_plugin.dart';



class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _PiningSslData {
  String serverURL = 'https://serverscale.herokuapp.com/logout';
  HttpMethod httpMethod = HttpMethod.Get;
  Map<String, String> headerHttp = Map();
  String allowedSHAFingerprint = '99:E0:DA:5F:A7:92:41:75:1B:D5:41:FD:A5:DA:EA:F7:E4:A7:0A:72';
  int timeout = 60;
  late SHA sha = SHA.SHA1;
}

class _LoginPageState extends State<LoginPage> {
  late String pseudo;
  late String password;
  _PiningSslData _data = _PiningSslData();
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
  }

  Future<void> LoginMethod(String username, String password, BuildContext context) async {
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
      try{
      String checkMsg = await SslPinningPlugin.check(
          serverURL : 'https://serverscale.herokuapp.com/logout',
          httpMethod : HttpMethod.Get,
          headerHttp : Map(),
          allowedSHAFingerprints :['99 E0 DA 5F A7 92 41 75 1B D5 41 FD A5 DA EA F7 E4 A7 0A 72'],
          timeout : 60,
          sha : SHA.SHA1);

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(checkMsg),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
      if (checkMsg.toString() != 'CONNECTION_SECURE'){
        return;
      }
      Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(profile : Profile.fromJson(jsonDecode(response.body)))));}
      catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      ); 
      }

      }
    }
    // If the server did return a 200 response,
    // then parse the JSON.
  else {
    // If the server did not return a 200 response,
    // then throw an exception.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error : unable to connect to server"),
            ));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(30),
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
                        LoginMethod(pseudo, password,context);
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
