import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("This is the home page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Route to settings page
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
