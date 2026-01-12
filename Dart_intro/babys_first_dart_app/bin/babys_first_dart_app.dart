import 'dart:io';
import 'package:babys_first_dart_app/prompt_helpers.dart';

void main(List<String> arguments) {
  stdout.writeln('Hello DMIT 2504 A01');
  var favNum = promptForInt('What is your favourite number?');
  stdout.writeln('Your favourite number is $favNum');
}
