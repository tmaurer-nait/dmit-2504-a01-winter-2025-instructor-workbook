import 'package:flutter/material.dart';

// By extending change notifier I make this class listenable
// Other classes can listen for changes and respond to them
class ApplicationState extends ChangeNotifier {
  ApplicationState();

  // Boolean tracks whether or not a user is logged in
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  // TODO: Connect this to firebase auth

  // TODO: Notify listeners of changes to loggedIn status
}
