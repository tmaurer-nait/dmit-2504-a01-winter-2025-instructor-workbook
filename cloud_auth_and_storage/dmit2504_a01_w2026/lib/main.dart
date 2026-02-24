import 'package:flutter/material.dart';

import 'package:dmit2504_a01_w2026/pages/home_page.dart';
import 'package:dmit2504_a01_w2026/state/app_state.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async {
  // Makes sure our widget binding is ready to go
  WidgetsFlutterBinding.ensureInitialized();

  var state = ApplicationState();

  // Then run the app
  runApp(MainApp(applicationState: state));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.applicationState, super.key});

  final ApplicationState applicationState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(appState: applicationState),
        // The sign in screen from Firebase UI Auth
        '/sign-in': (context) => SignInScreen(
          // A list of actions we can bind to sign in functionality
          actions: [
            // Callback is called whenever the auth state changes
            AuthStateChangeAction((context, state) {
              // The auth state has changed, find out what happened an deal with it
              // The following is shorthand for variable assignment based on
              // another variable
              final user = switch (state) {
                // User signed in
                SignedIn state => state.user,
                // User was first created
                UserCreated state => state.credential.user,
                // Anything else
                _ => null,
              };

              // If user is null do nothing
              if (user == null) return;

              // If user was created update the username
              if (state is UserCreated) {
                // New user, we'll set the username to be the first part
                // of their email address
                user.updateDisplayName(user.email!.split('@').first);
              }

              // If user was created or sign in navigate to home page
              // This first pop removes the dialog
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ],
        ),
        // The profile screen from Firebase UI Auth
        '/profile': (context) => ProfileScreen(
          actions: [
            // When there is a signout navigate to home
            SignedOutAction((context) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ],
        ),
      },
    );
  }
}
