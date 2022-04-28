
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/services/logout.dart';
import 'package:flutter_application_1/views/profile_page.dart';


class DirectoryPage extends StatelessWidget {
  final List<Profile> directory;
  static const routeName = '/directory-page';

  const DirectoryPage({Key? key, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Directory"),
        actions: <Widget>[IconButton(icon: const Icon(Icons.power_settings_new_rounded), onPressed: () {LogoutMethod(context);})]),
        body: ListView.builder(
          itemCount: directory.length,
          itemBuilder: (BuildContext context, int position) {
            Profile item = directory.elementAt(position);
            return ListTile(
              title: Text("${item.firstName} ${item.lastName}"),
            );
          }),
    );
  }
}
