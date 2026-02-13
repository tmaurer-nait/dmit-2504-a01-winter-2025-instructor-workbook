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

  // TODO: Close DB

  // TODO: Get all Dogs

  // TODO: Insert Dog

  // TODO: Delete Dog

  // TODO: Update Dog <- Student Exercise
}
