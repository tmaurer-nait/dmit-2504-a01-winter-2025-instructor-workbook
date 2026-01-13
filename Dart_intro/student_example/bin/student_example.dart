import 'package:student_example/models/student.dart';

void main(List<String> arguments) {
  var student1 = Student(lName: 'Maurer', fName: 'Tom');
  var student2 = Student(id: 100, fName: 'Jimbob', lName: 'Thornton');
  print(student2.firstName);
  student1.firstName = "Jamesbob";
  print(student1.firstName);

  var emptyStudent = Student.emptyStudent();
}
