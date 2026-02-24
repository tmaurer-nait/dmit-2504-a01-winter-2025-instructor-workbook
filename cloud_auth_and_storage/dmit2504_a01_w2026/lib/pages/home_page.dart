import 'package:dmit2504_a01_w2026/state/app_state.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.appState, super.key});

  // reference to the application state (with the loggedIn info)
  final ApplicationState appState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Listenable Builders work by calling the builder function
        // any time the listenable changes
        child: ListenableBuilder(
          listenable: appState,
          builder: (context, _) {
            return appState.loggedIn
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    child: Text('Profile'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/sign-in');
                    },
                    child: Text('Sign In'),
                  );
          },
        ),
      ),
    );
  }
}
