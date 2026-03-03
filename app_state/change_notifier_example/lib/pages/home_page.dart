import 'package:flutter/material.dart';

import 'first_name_page.dart';
import 'last_name_page.dart';

// References the app state class
import 'package:change_notifier_example/models/user.dart';

class HomePage extends StatelessWidget {
  // variable initialization before the constructor body executes is done with :
  HomePage({super.key}) : user = User('Vexus', 'Locus') {
    // Constructor body would go here
  }

  // App state that is shared to the child widgets
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FirstNamePage(user: user),
                ),
              ),
              child: const Text('First Name Page'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LastNamePage()),
              ),
              child: const Text('Last Name Page'),
            ),
          ],
        ),
      ),
    );
  }
}
