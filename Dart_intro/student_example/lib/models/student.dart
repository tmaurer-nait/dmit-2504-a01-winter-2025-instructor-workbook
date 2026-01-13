class Student {
  // Properties
  late String _firstName;
  late String _lastName;
  late int _idNumber;

  // Constructors
  Student({required String fName, required String lName, int id = 1}) {
    firstName = fName;
    lastName = lName;
    idNumber = id;
  }

  Student.emptyStudent() {
    _firstName = '';
    _lastName = '';
    _idNumber = 0;
  }

  // Getters/Setters
  String get firstName => _firstName;

  set firstName(String value) {
    if (value.isEmpty) {
      throw Exception("First name must be at least 1 character");
    }

    _firstName = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    if (value.isEmpty) {
      throw Exception("Last name must be at least 1 character");
    }

    _lastName = value;
  }

  int get idNumber => _idNumber;

  set idNumber(int value) {
    if (value <= 0) {
      throw Exception("Id must be positive");
    }

    _idNumber = value;
  }

  String get fullName => '$_firstName $_lastName';

  // Methods
  void incrementId() {
    _idNumber++;
  }
}
