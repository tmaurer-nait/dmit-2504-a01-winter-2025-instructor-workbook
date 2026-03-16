class User {
  // Two properties name, email
  late String name;
  late String email;

  // Default Generative Contructor
  User({required this.name, required this.email});

  // toString method that outputs 'Name: <name>, Email: <email>'
  @override
  String toString() {
    return 'Name: $name, Email: $email';
  }
}
