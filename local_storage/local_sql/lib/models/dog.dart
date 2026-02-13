// Simple model class with 3 attributes and a generative constructor
class Dog {
  // We will be handling ID generation on the frontend. Usually you'd let the DB handle this
  // and therefore this would need to be nullable.
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  // This constructor turns a Map into a Dog
  // The Map looks like this {'ColumnName': value} (eg. {'id': 1, 'name': 'Rover', 'age': 5})
  factory Dog.fromMap(Map<String, Object?> dogMap) => Dog(
    id: dogMap['id'] as int,
    name: dogMap['name'] as String,
    age: dogMap['age'] as int,
  );

  // This function turns our Dog into a Map so that SQFlite can interact with it
  Map<String, Object?> toMap() => {'id': id, 'name': name, 'age': age};
}
