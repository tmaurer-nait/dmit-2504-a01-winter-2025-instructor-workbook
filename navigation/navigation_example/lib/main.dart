import 'package:flutter/material.dart';
import 'package:navigation_example/pages/page_one.dart';
import 'package:navigation_example/pages/page_two.dart';
// Utilize constant route names to prevent typo errors
import 'package:navigation_example/constants/routes.dart' as routes;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The home property determines the first page shown.
      // There is another way to do this with routes as shown below.
      // home: PageOne(),

      // There is a third way to do routing/home pages etc. We'll get to that in the future
      // onGenerateRoute:

      // The routes argument takes in a map of String to builder function
      // We can use those strings to identify the page we want to route to
      // in future uses of pushNamed() or with deep links
      routes: {
        // These strings map to functions that take in a BuildContext and return a page Widget
        routes.homeRoute: (context) => PageOne(),
        routes.pageTwoRoute: (context) => PageTwo(),
      },
    );
  }
}
