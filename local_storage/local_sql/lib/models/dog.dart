// Simple model class with 3 attributes and a generative constructor
class Dog {
  // We will be handling ID generation on the frontend. Usually you'd let the DB handle this
  // and therefore this would need to be nullable.
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});
}
