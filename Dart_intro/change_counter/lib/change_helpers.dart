import 'dart:io';

// Returns a list of coins sorted by ascending face-value
List<int> promptForChange() {
  // Initialize the list
  var output = [0, 0, 0, 0, 0, 0];
  // Create the list of coin-types for prompting
  var coinTypes = [
    'pennies',
    'nickels',
    'dimes',
    'quarters',
    'loonies',
    'toonies',
  ];

  // Loop through coin types
  for (var i = 0; i < coinTypes.length; i++) {
    //  Prompt user
    stdout.writeln('How many ${coinTypes[i]} do you have?');

    //  validate input
    late int coinCount;
    try {
      coinCount = int.parse(stdin.readLineSync()!);
    } catch (e) {
      throw Exception('User did not enter an integer');
    }

    if (coinCount < 0) {
      throw Exception('User entered a negative number');
    }

    //  update output list
    output[i] += coinCount;
  }

  // Return output list
  return output;
}

// Return the total value of the change (in pennies)
int getTotal(List<int> changeCounts) {
  int total = 0;

  total += changeCounts[0];
  total += changeCounts[1] * 5;
  total += changeCounts[2] * 10;
  total += changeCounts[3] * 25;
  total += changeCounts[4] * 100;
  total += changeCounts[5] * 200;

  return total;
}
