import 'package:flutter/material.dart';

import 'package:change_notifier_example/models/user.dart';

class FirstNamePage extends StatelessWidget {
  const FirstNamePage({required this.user, super.key});

  // References the app state
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Name Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            // Whenever the listenable changes, call the builder and draw that to the screen
            ListenableBuilder(
              // listening to the user app state (passed in from above)
              listenable: user,
              builder: (_, _) {
                // Builds a simple text widget based on user
                return Text('User name: ${user.firstName} ${user.lastName}');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Update our user first name here
        onPressed: () {
          // Updates the state, by calling the setter, which then notifies any listeners
          user.firstName = 'Chihiro';
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
