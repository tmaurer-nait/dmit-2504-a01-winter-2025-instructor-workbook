import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dmit2504_a01_w2026/firebase_options.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// I hide email auth provider to prevent import collisions between this and
// firebase ui auth above
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

// By extending change notifier I make this class listenable
// Other classes can listen for changes and respond to them
class ApplicationState extends ChangeNotifier {
  // This class's job is to broadcast changes in firebase to the rest of the app
  ApplicationState();

  // Boolean tracks whether or not a user is logged in
  bool _loggedIn = true;
  bool get loggedIn => _loggedIn;

  // Connects the app state to firebase auth and initializes
  // firebase connection to the app itself
  Future<void> init() async {
    // Connect to firebase before starting the app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Configure auth providers, telling firebase ui auth screens
    // to show/work with email login
    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    // Whenever firebase auth user changes (user logs in or out)
    // notify all my listeners of that change
    FirebaseAuth.instance.userChanges().listen((user) {
      // If they logged out user is null
      if (user == null) {
        _loggedIn = false;
      } else {
        // Otherwise they logged in and user is not null
        _loggedIn = true;
      }
      // Once we have updated our state variables notify any listeners
      // This function is built in to the ChangeNotifier class that we extended
      notifyListeners();
    });
  }

  // TODO: Notify listeners of changes to loggedIn status
}
