import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  User(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  String? _firstName;
  String? _lastName;

  String? get firstName => _firstName;
  String? get lastName => _lastName;

  set firstName(String newFirstName) {
    _firstName = newFirstName;

    // After the first name changes, notify all listeners so they
    // can update themselves accordingly
    notifyListeners(); // This comes from ChangeNotifier
  }

  set lastName(String newLastName) {
    _lastName = newLastName;

    // After the last name changes, notify all listeners so they
    // can update themselves accordingly
    notifyListeners(); // This comes from ChangeNotifier
  }
}
