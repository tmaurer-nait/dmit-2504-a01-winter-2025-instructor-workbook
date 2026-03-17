import 'package:flutter/material.dart';

import 'package:test_example/widgets/user_widget.dart';
import 'package:test_example/models/user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to the Home Page'),
              UserWidget(
                user: User(name: 'Tom', email: 'tmaurer@nait.ca'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
