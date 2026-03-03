import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/models/user.dart';

class LastNamePage extends StatelessWidget {
  const LastNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap this scaffold in a consumer so that we can access the app state
    // The subtype of the consumer tells us which provider to use
    return Consumer<User>(
      // Whenever the provider's user changes we call this build method with the
      // new user values
      builder: (context, user, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Last Name Page')),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24.0),
                // I don't need a listenable builder anymore, because the
                // consumer does the listening for me
                Text('User name: ${user.firstName} ${user.lastName}'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            // Update our user firs name here
            onPressed: () {
              user.lastName = 'Johnson';
            },
            child: const Icon(Icons.update),
          ),
        );
      },
    );
  }
}
