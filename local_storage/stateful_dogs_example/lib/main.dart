import 'package:flutter/material.dart';
import 'package:stateful_dogs_example/widgets/dog_image.dart';

// flutter pub add shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _isDarkMode = false;

  // Helper function that reads the dark mode value from shared preferences
  Future<bool> _readDarkModeFromSharedPrefs() async {
    // First I get the shared preferences instance
    final prefs = await SharedPreferences.getInstance();

    // Second I read the bool from it
    return prefs.getBool('darkMode') ?? false;
  }

  @override
  void initState() {
    super.initState();
    _readDarkModeFromSharedPrefs().then((isDarkMode) {
      setState(() {
        _isDarkMode = isDarkMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text('Dog Rating App')),
        body: Center(
          child: Column(
            children: [
              DogImage(),
              SwitchListTile(
                value: _isDarkMode,
                onChanged: (value) async {
                  // When they toggle the switch set state and update shared prefs
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                  // write to shared prefs
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('darkMode', value);
                },
                title: Text('Dark Mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
