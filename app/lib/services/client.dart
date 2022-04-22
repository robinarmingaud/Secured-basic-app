import 'dart:convert';

import 'package:flutter_application_1/models/profile.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class Client {
  String username;
  String password;

  Client(this.username, this.password);

  Future<Profile> fetchProfile() async {
    var body = jsonDecode(await rootBundle.loadString("assets/profile.json"));

    return Profile.fromJson(body);
  }

}