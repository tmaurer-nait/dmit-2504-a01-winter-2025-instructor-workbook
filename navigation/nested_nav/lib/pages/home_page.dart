import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("This is the home page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This takes us to the settings manager
          Navigator.of(context).pushNamed('/settings/settings-home');
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
