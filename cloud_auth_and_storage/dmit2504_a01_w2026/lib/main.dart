import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Makes sure our widget binding is ready to go
  WidgetsFlutterBinding.ensureInitialized();

  // Connect to firebase before starting the app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Then run the app
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
