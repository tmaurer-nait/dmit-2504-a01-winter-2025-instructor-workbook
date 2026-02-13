import 'package:flutter/material.dart';

import 'package:local_sql/models/dog.dart';
import 'package:local_sql/managers/dog_db_manager.dart';

// needed for randomness
import 'dart:math';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});
  final dogManager = DogDbManager.instance;

  // We need a random number generator for any random things
  final rng = Random();
  final randomNameChoices = [
    'Snoop',
    'Scooby',
    'Scrappy-Doo',
    'Clifford',
    'Ruth Bader Ginsbark',
  ];

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Dog> dogs = [];
  // This variable is used for our autoincrement ids
  int lastId = 0;

  void _loadDogs() async {
    // when interacting with the database use try catches
    try {
      // get all dogs from the db
      final dbDogs = await widget.dogManager.getDogs();

      // then set the state to show those dogs
      setState(() {
        dogs = dbDogs;
        lastId = dbDogs.isNotEmpty ? dbDogs.last.id : 0;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  @override
  void dispose() {
    super.dispose();
    widget.dogManager.closeDB();
  }

  // Normally we would create the dogs in a real way based off of API calls or user inputs etc. (we are short on time)
  // So instead we will create the dogs in a test data function
  void _createTestData() async {
    try {
      // create 3 dogs
      for (var i = 0; i < 3; i++) {
        // Get a random name
        final name =
            widget.randomNameChoices[widget.rng.nextInt(
              widget.randomNameChoices.length - 1,
            )];

        // Get the next ID
        final id = lastId + i + 1;

        // create the dog
        final newDog = Dog(name: name, id: id, age: widget.rng.nextInt(20));

        // add it to the DB
        await widget.dogManager.insertDog(newDog);
      }
      // Load the dogs again (This is OPTION 2 from our notes)
      _loadDogs();
    } catch (e) {
      print(e);
    }
  }

  void _removeDog(int id) async {
    try {
      // Again this uses option 2 from the notes
      await widget.dogManager.deleteDog(id);
      _loadDogs();
    } catch (e) {
      print(e);
    }
  }

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
            return ListTile(
              title: Text('${dog.name} - ${dog.age} years old'),
              onTap: () {
                _removeDog(dog.id);
              },
            );
          },
          // If parameters are not needed in the function body but are required for correct function signature
          // You can use underscores to name them. This marks them as "ignorable"
          separatorBuilder: (_, _) => Divider(),
          // Calls the builder functions once per itemCount. (essentially a for loop up to itemCount)
          itemCount: dogs.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createTestData,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
