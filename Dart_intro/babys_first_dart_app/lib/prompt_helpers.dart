import 'dart:io';

int promptForInt(String message) {
  stdout.writeln(message);

  var userInput = stdin.readLineSync();

  // Same as the following
  // if (userInput == null) {
  //   return int.parse('0');
  // } else {
  //   return int.parse(userInput);
  // }

  return int.parse(userInput ?? '0');
}
