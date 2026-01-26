import 'package:flutter/material.dart';
import 'package:profile_example/pages/profile_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.pink,
      cardColor: Colors.yellow,
    ),
    fontFamily: 'BitCountSingle',
  );

  @override
  Widget build(BuildContext context) {
    final darkTheme = lightTheme.copyWith(
      colorScheme: ColorScheme.fromSwatch(
        cardColor: Colors.red,
        backgroundColor: Colors.red,
        brightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      home: ProfilePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
