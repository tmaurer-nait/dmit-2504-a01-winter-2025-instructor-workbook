import 'package:flutter/material.dart';

import 'package:test_example/models/user.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({super.key, required this.user});

  final User user;

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  var _showInfo = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showInfo) Text(widget.user.name),
        if (_showInfo) Text(widget.user.email),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showInfo = !_showInfo;
            });
          },
          child: Text('Toggle Info'),
        ),
      ],
    );
  }
}
