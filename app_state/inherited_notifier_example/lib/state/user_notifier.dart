import 'package:flutter/material.dart';
import 'package:inherited_notifier_example/models/user.dart';

// This class is only responsible for giving access to the user
// "state" model. That still handles notifying listerners of changes
class UserNotifier extends InheritedNotifier<User> {
  const UserNotifier({super.key, required User user, required Widget child})
    : super(notifier: user, child: child);

  static UserNotifier? maybeOf(BuildContext context) {
    // Searches the context (The widget tree) for a UserNotifier
    return context.dependOnInheritedWidgetOfExactType<UserNotifier>();
  }

  // When I call this, it should return the user that was passed into the constructor
  static User of(BuildContext context) {
    // Check if a UserNotifier exists in the widget tree (using the context)
    final result = maybeOf(context);

    // If not throw an error
    if (result == null || result.notifier == null) {
      throw StateError('No UserNotifier found in context');
    }

    // Else return the User of that UserNotifier
    return result.notifier!;
  }
}
