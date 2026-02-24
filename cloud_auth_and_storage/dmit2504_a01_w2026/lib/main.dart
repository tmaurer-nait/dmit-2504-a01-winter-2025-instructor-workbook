import 'package:flutter/material.dart';

import 'package:dmit2504_a01_w2026/pages/home_page.dart';
import 'package:dmit2504_a01_w2026/state/app_state.dart';

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
        // TODO: Replace with sign in flow
        '/sign-in': (context) => Placeholder(),
        // TODO: Replace with profile page
        '/profile': (context) => Placeholder(),
      },
    );
  }
}
