import 'package:flutter/material.dart';
import 'package:profile_example/widgets/profile_info.dart';
import 'package:profile_example/widgets/profile_picture.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Layout Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Employee Profile',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            ProfilePicture(),
            Padding(
              padding: EdgeInsets.only(left: 8, top: 16),
              child: Column(
                children: [
                  ProfileInfo(label: 'Role', value: 'Evil Forces Fighter'),
                  ProfileInfo(label: 'Team', value: 'Tremorton'),
                  ProfileInfo(label: 'Handle', value: '@JWakes'),
                  ProfileInfo(label: 'Supervisor', value: 'Dr. Nora Wakeman'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
