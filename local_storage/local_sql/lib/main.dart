import 'package:flutter/material.dart';

import 'package:local_sql/models/dog.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Dog> dogs = [
    Dog(id: 1, name: 'Snoop', age: 60),
    Dog(id: 2, name: 'Scooby', age: 25),
    Dog(id: 3, name: 'Scrappy-Doo', age: 46),
    Dog(id: 4, name: 'Clifford', age: 35),
    Dog(id: 5, name: 'Ruth Bader Ginsbark', age: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.separated(
          // Item builder and separator builder are builder functions that take in a build context
          // and return a widget. They also take in the index of the given item to build
          itemBuilder: (context, idx) {
            // Get the dog for the current index
            final dog = dogs[idx];

            // Display a list tile for that dog
            return ListTile(title: Text('${dog.name} - ${dog.age} years old'));
          },
          // If parameters are not needed in the function body but are required for correct function signature
          // You can use underscores to name them. This marks them as "ignorable"
          separatorBuilder: (_, _) => Divider(),
          // Calls the builder functions once per itemCount. (essentially a for loop up to itemCount)
          itemCount: dogs.length,
        ),
      ),
    );
  }
}
