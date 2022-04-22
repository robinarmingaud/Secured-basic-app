import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/views/directory_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Display profile list', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    const List<Profile> directory = [
      Profile("Brad","Pitt","https://media.gqmagazine.fr/photos/6082bd46e24bc2c55a7e1c4f/1:1/w_120", "William Bradley Pitt (born December 18, 1963) is an American actor and film producer."),
      Profile("Georges","Clooney","",""),
    ];

    await tester.pumpWidget(const MaterialApp(home: DirectoryPage(directory: directory,),));

    expect(find.text('Keyser Söze'), findsNothing);
    expect(find.text('Brad Pitt'), findsOneWidget);
    expect(find.text('Georges Clooney'), findsOneWidget);
  });

}
