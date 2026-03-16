// Import testing framework
// (flutter test extends test which is dart's testing framework)
import 'package:flutter_test/flutter_test.dart';

// Import the code you are testing
import 'package:test_example/models/user.dart';

// flutter test <Path to test (defaults to test)> -r expanded
// flutter test -r expanded

void main() {
  // Allows me to organize my tests and label them
  group('User Model Tests', () {
    late User user;

    // Runs once before each test
    setUp(() {
      user = User(name: 'Tom', email: 'tmaurer@nait.ca');
    });

    // Takes two args, name of the test, a callback that is the actual test
    // It's good practice to name your tests with "should" and the functionality
    test('User should have a readable name and email', () {
      // this validates that arg 1 == arg 2
      expect(user.name, 'Tom');
      expect(user.email, 'tmaurer@nait.ca');
    });

    test('User should override toString correctly', () {
      // Arrange - set up your test things
      final expected = 'Name: Tom, Email: tmaurer@nait.ca';

      // Act - Do the thing you are testing
      final actual = user.toString();

      // Assert - Validate the output
      expect(actual, expected);
    });
  });
}
