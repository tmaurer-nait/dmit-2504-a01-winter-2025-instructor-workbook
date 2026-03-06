class User {
  User(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
  }

  late final String _firstName;
  late final String _lastName;

  String get firstName => _firstName;
  String get lastName => _lastName;

  // Again we remove the setters to make this class immutable
  // I don't want any widget to change the state without going through bloc/cubit
  // Otherwise they could bypass my logging, cause hidden state changes, break testing etc.
}
