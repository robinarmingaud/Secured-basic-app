// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
// ignore: unused_import
import 'package:flutter_application_1/views/profile_page.dart';

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
              trailing: const Icon(Icons.arrow_right),
              title: Text("${item.firstName} ${item.lastName}"),
            );
          }),
    );
  }
}
