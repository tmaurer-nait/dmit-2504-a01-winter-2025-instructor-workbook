import 'package:flutter/material.dart';

import 'package:dmit2504_a01_w2026/firebase_options.dart';
import 'package:dmit2504_a01_w2026/models/todo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// I hide email auth provider to prevent import collisions between this and
// firebase ui auth above
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

// By extending change notifier I make this class listenable
// Other classes can listen for changes and respond to them
class ApplicationState extends ChangeNotifier {
  // This class's job is to broadcast changes in firebase to the rest of the app
  ApplicationState() {
    // Call the init function to connect to firebase and setup listeners
    init();
  }

  // Boolean tracks whether or not a user is logged in
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  // Variable that tracks the currently signed in user
  User? _user;
  User? get user => _user;
  set user(User? user) {
    if (user == null) {
      throw ArgumentError('Cannot set user to null');
    }
    _user = user;
  }

  // Because we've combined communication with app state we are going to add
  // all of our todo CRUD operations to the app state file

  // Variable that tracks the logged in user's todos
  List<Todo>? _todos;
  List<Todo>? get todos {
    if (user == null) {
      throw StateError('Cannot get todos when user is null');
    }
    return _todos;
  }

  set todos(List<Todo>? todos) {
    if (user == null) {
      throw StateError('Cannot set todos when user is null');
    }
    if (todos == null) {
      throw ArgumentError('Cannot set todos to null');
    }
    _todos = todos;
  }

  void _fetchTodos() {
    if (user == null) {
      throw StateError('Cannot get todos when user is null');
    }

    // First access the firestore instance
    FirebaseFirestore.instance
        // Then get the specific collection we need
        .collection('todos/${user!.uid}/todos')
        .get()
        .then((collectionSnapshot) {
          // Then set the app state to that List of Todos
          todos = collectionSnapshot.docs
              // convert every document into a Todo
              .map((doc) => Todo.fromFirestore(doc))
              .toList();
        });
  }

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
        // When they log in, track the user that has logged in
        this.user = user;
        // Once we've logged in as a user, preload their todos for later access
        _fetchTodos();
      }
      // Once we have updated our state variables notify any listeners
      // This function is built in to the ChangeNotifier class that we extended
      notifyListeners();
    });
  }
}
