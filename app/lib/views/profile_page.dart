import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/services/directory.dart';
import 'package:flutter_application_1/services/logout.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  final Profile profile;

  const ProfilePage({Key? key, required this.profile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),
      actions: <Widget>[IconButton(icon: const Icon(Icons.power_settings_new_rounded), onPressed: () {LogoutMethod(context);}),
      IconButton(icon: const Icon(Icons.home_filled), onPressed: () {DirectoryMethod(context);})]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(backgroundImage:NetworkImage(profile.thumbnailPath), maxRadius: 64,),
              Text(
                '${profile.firstName} ${profile.lastName}',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(profile.biography, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
