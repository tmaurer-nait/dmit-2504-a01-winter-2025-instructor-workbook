import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:dmit2504_a01_w2026/pages/home_page.dart';
import 'package:dmit2504_a01_w2026/state/app_state.dart';

void main() async {
  var state = ApplicationState();
  // Makes sure our widget binding is ready to go
  WidgetsFlutterBinding.ensureInitialized();

  // Connect to firebase before starting the app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        '/sign-in': (context) => Placeholder(),
        '/profile': (context) => Placeholder(),
      },
    );
  }
}
