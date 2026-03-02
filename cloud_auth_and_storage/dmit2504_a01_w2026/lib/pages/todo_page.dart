import 'package:flutter/material.dart';
import 'package:dmit2504_a01_w2026/state/app_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({required this.appState, super.key});

  final ApplicationState appState;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('To Do Page')));
  }
}
