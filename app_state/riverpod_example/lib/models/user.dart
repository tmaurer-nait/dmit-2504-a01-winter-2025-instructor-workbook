// flutter pub add flutter_riverpod
import 'package:flutter_riverpod/legacy.dart';

class User {
  User(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
  }

  late final String _firstName;
  late final String _lastName;

  String get firstName => _firstName;
  String get lastName => _lastName;

  // I removed the setters to make the state immutable
  // It's good practice to do this so that it can never be changed,
  // and instead to update the state you create a new state and use that
  // It makes it more traceable, testable and robust
}

// Here we create a user provider that "provides" access to the user state
// for our entire application. Our state is a User as denoted in the subtype
// Riverpod has many different providers, we are using StateProvider because it's simple
final userProvider = StateProvider<User>(
  // When initialized we call this function to create the first state
  (ref) => User('Jimothy', 'Anderson'),
);
