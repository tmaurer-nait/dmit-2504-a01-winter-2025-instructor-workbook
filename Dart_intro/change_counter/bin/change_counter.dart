import 'package:change_counter/change_helpers.dart';
import 'dart:io';

void main(List<String> arguments) {
  var counts = promptForChange();
  var total = getTotal(counts);

  stdout.writeln('Your change is worth \$${total / 100}');
}
