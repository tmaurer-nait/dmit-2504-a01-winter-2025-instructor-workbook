import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/models/user.dart';

// We replace stateless widget with consumer widget to access our providers
class FirstNamePage extends ConsumerWidget {
  const FirstNamePage({super.key});

  @override
  // the build method now needs a second parameter (ref) which is a reference to our provider scope
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ref for changes to the user provider (app state)
    // This is doing lazy initialization - the first time it's called anywhere in the app we bind
    // the userProvider to the provider scope and initialize the state. After that we just read the value
    // We do ref.watch instead of ref.read so that we respond to changes in the userProvider
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('First Name Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            Text('User name: ${user.firstName} ${user.lastName}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Update our user firs name here
        onPressed: () {
          // While we could just use the user defined above, for demo purposes,
          // here is how you read the state one time without watching for changes
          final currentUser = ref.read(userProvider);

          // Here i update the state values
          ref.read(userProvider.notifier).state = User(
            'Michael',
            currentUser.lastName,
          );
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
