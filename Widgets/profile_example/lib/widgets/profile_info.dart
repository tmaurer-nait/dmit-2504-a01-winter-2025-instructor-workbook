import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(value, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
