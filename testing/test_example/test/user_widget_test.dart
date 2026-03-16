// Framework
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Code we are testing
import 'package:test_example/models/user.dart';
import 'package:test_example/widgets/user_widget.dart';

void main() {
  late User user;
  late Widget app;

  group('User Widget Tests', () {
    // In my setup I render the singular widget into an empty material app
    // with an empty scaffold
    setUp(() {
      user = User(name: 'Joe', email: 'Joe@gmail.com');

      app = MaterialApp(
        home: Scaffold(body: UserWidget(user: user)),
      );
    });

    // Instead of using test() I use testWidgets() <- This allows access to  a tester
    // The tester is essentially a reference to the headless rendering environment
    // The callback is now async which allows us to press buttons, wait for renders etc.
    testWidgets('UserWidget should display name and email on load', (
      tester,
    ) async {
      // Arrange
      // pump means render a frame
      await tester.pumpWidget(app);

      // Act (ish)
      // In UI testing you often use finders. These look for things on the page
      // You should try to find widgets the same way users do
      final nameFinder = find.text('Joe');
      final emailFinder = find.text('Joe@gmail.com');
      final buttonFinder = find.byType(ElevatedButton);

      // Assert
      // Our expects can now use matchers with finders to check for a specific number
      // of widgets. There are many different finders (findsOne, findsNothing, findsAny)
      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('Should hide info when button is pressed', (tester) async {
      await tester.pumpWidget(app);

      final nameFinder = find.text('Joe');
      final emailFinder = find.text('Joe@gmail.com');
      final buttonFinder = find.byType(ElevatedButton);

      // Validate that it finds the widgets on load (and then later hides them)
      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);

      // Tester can also be used to interact with widgets in the headless environment
      await tester.tap(buttonFinder);

      // I need to wait for the tap to be handled, setState to be called, and the
      // new frames to be rendered. I do this with one of two options
      // await tester.pump(Duration(seconds: 1)); // render frames for 1 second
      await tester.pumpAndSettle(); // render frames until none are queued

      expect(nameFinder, findsNothing);
      expect(emailFinder, findsNothing);
      expect(buttonFinder, findsOne);
    });
  });
}
