class Film {
  // Properties
  late final String id;
  late final String title;
  late final String description;

  // Constructors
  // Film({
  //   required String id,
  //   required String title,
  //   required String description,
  // }) {
  //   this.id = id;
  //   this.title = title;
  //   this.description = description;
  // }
  // Same as below
  Film({required this.id, required this.description, required this.title});

  factory Film.fromJson(dynamic json) {
    return Film(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  // Methods
  @override
  String toString() {
    return '$title is a movie about $description';
  }
}
