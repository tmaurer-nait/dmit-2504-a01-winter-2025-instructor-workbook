import 'package:flutter/material.dart';

import 'pages/home_page.dart';

import 'package:inherited_notifier_example/models/user.dart';
import 'package:inherited_notifier_example/state/user_notifier.dart';

void main() {
  runApp(const MainApp());
}

// This is the app state that is being shared
User user = User('Eugene', 'Owens');

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the matierial app with a user notifier. That allows access to the
    // user defined above from any widget in the widget tree
    return UserNotifier(
      user: user,
      child: MaterialApp(
        home: Scaffold(body: Center(child: HomePage())),
      ),
    );
  }
}
