import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image(
            height: 250,
            width: 250,
            image: AssetImage('assets/images/jenny_wakeman.jpg'),
          ),
        ),
        Text(
          'Jenny Wakeman',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
