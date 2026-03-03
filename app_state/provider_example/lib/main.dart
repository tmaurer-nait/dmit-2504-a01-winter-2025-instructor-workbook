import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'package:provider_example/models/user.dart';

void main() {
  // We will wrap our main app in a provider which will "provide" access to our
  // app state. In our case the user model will now be available to any consumers
  // in the widget tree
  runApp(
    ChangeNotifierProvider(
      // Initialize the app state here
      create: (context) => User('Gary', 'Gygax'),
      // Then start the main app
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: HomePage())),
    );
  }
}
