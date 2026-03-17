// flutter pub add "dev:integration_test:{sdk: flutter}"
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import what I want to test
import 'package:test_example/main.dart';

void main() {
  // Connect to our integration test framework
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // After this the rest of the file looks basically just like our widget tests

  group('end-to-end app tests', () {
    // First test ensures all the text is there
    testWidgets('start app and ensure all text is visible', (tester) async {
      //Load the app
      await tester.pumpWidget(MainApp());

      // verify text is visible
      expect(find.text('Tom'), findsOneWidget);
      expect(find.text('tmaurer@nait.ca'), findsOneWidget);
      expect(find.text('Welcome to the Home Page'), findsOneWidget);
    });

    // Second test validates button toggle functionality
    testWidgets('Tap on button, verify that name and email disappear', (
      tester,
    ) async {
      // load the main app
      await tester.pumpWidget(MainApp());

      expect(find.text('Tom'), findsOneWidget);
      expect(find.text('tmaurer@nait.ca'), findsOneWidget);

      // find the button
      final button = find.byType(ElevatedButton);

      // Press the button
      await tester.tap(button);

      // Wait for rerenders
      await tester.pumpAndSettle();

      expect(find.text('Tom'), findsNothing);
      expect(find.text('tmaurer@nait.ca'), findsNothing);

      // Toggle back on
      // Press the button
      await tester.tap(button);

      // Wait for rerenders
      await tester.pumpAndSettle();

      expect(find.text('Tom'), findsOneWidget);
      expect(find.text('tmaurer@nait.ca'), findsOneWidget);
    });
  });
}
