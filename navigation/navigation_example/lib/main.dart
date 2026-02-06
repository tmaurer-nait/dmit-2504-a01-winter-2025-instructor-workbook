import 'package:flutter/material.dart';
import 'package:navigation_example/pages/page_one.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // The home property determines the first page shown.
      // There is another way to do this with routes as shown below.
      home: PageOne(),
    );
  }
}
