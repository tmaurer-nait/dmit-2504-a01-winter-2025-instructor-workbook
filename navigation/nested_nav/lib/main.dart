import 'package:flutter/material.dart';
import 'package:nested_nav/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // OnGenerateRoute allows us to return different pages based on
      // some function that we determine. It is passed in the Route Settings
      // of the current page request.
      onGenerateRoute: (settings) {
        // This will hold the value of whatever page we are routing to
        Widget page;

        switch (settings.name) {
          case '/':
            page = HomePage();
            break;
          default:
            // This is where you can handle routing to a non-existant route
            // eg. 404 not found page
            throw Exception('Unknown Route: ${settings.name}');
        }
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}
