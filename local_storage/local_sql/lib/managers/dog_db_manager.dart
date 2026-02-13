import 'package:local_sql/models/dog.dart';

// flutter pub add sqflite
import 'package:sqflite/sqflite.dart';

// flutter pub add path
import 'package:path/path.dart';

// This class will handle all of our database communication
class DogDbManager {
  // This class is a singleton so we will make the constructor private
  // that way no other class can call it, we can only call the constructor from this file
  const DogDbManager._();

  // To make the singleton instance accessible I create a public static const
  static const DogDbManager instance = DogDbManager._();

  // Set up our initial variabls for the db
  static const _dbName = 'a01_dogs.db';
  static const _dbVersion = 1;
  static Database? _database; // Private internal reference to the DB

  // a public getter, that either opens a connection to the DB or
  // returns the open db if a connection has already been established
  Future<Database> get database async {
    // if a connection is already open just return that
    if (_database != null) return _database!;

    // Otherwise open the connection, store it in the variable, and return that
    _database = await _connectToDB();
    return _database!;
  }

  // Connects to the DB, creating it if necessary
  Future<Database> _connectToDB() async {
    // Get the local db file location
    final dbPath = await getDatabasesPath();

    // join the dbPath to the dbName utilizing the path package (same as '$dbpath/$_dbName')
    final path = join(dbPath, _dbName);

    // Open the db connection, creating it if needed
    final db = openDatabase(
      path,
      onCreate: (database, _) {
        database.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: _dbVersion,
    );
    return db;
  }

  // Closes the DB Connection, and should be called in the dispose method of any widget that
  // opens a connection to the db to prevent corruption and other issues
  void closeDB() async {
    // call our getter to retrieve/open the db
    final db = await database;
    db.close();
    _database = null;
  }

  // Get all existing dogs from the database
  Future<List<Dog>> getDogs() async {
    final db = await database;

    // Queries the db for the dogs table. Returns a List<Map<String, Object?>> but we want a List<Dog>
    // So we need to convert it to our custom model class
    final dogMaps = await db.query('dogs');

    // Option 1: for loop
    // List<Dog> output = [];
    // for (final dogMap in dogMaps) {
    //   output.add(Dog.fromMap(dogMap));
    // }
    // return output;

    // Option 2: List.generate
    // return List.generate(dogMaps.length, (i) => Dog.fromMap(dogMaps[i]));

    // Option 3: List comprehension
    return [for (final dogMap in dogMaps) Dog.fromMap(dogMap)];
  }

  // Adds a dog to the DB
  Future<void> insertDog(Dog dog) async {
    final db = await database;

    // Takes in the table name to insert to, and a map of column names to values
    await db.insert(
      'dogs',
      dog.toMap(),
      // This parameter determines how to handle inserts where the id already exists as a PRIMARY KEY.
      // I chose to replace with the new dog
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Deletes a Dog from the db
  Future<void> deleteDog(int id) async {
    final db = await database;

    // THE FOLLOWING IS REALLY BAD, it opens you up to SQL injection
    // await db.delete('dogs', where: 'id = $id');
    // Instead we will sanitize the input utilizing whereArgs (SQFlite's built in sanitization)
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  // TODO: Update Dog <- Student Exercise
}
