import 'package:flutter/material.dart';
import 'package:dmit2504_a01_w2026/state/app_state.dart';
import 'package:dmit2504_a01_w2026/models/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({required this.appState, super.key});

  final ApplicationState appState;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _todoList = [];

  // When I first open this page, get all the user's todos from the app state
  @override
  void initState() {
    super.initState();
    setState(() {
      _todoList = widget.appState.todos ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kind of works like a for loop
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          // Index is the index of the item so get the actual todo
          final todo = _todoList[index];
          // Dismissible allows us to swipe away the widget
          return Dismissible(
            key: UniqueKey(),
            child: ListTile(
              title: Text(
                todo.description,
                style: TextStyle(
                  decoration: todo.isComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                value: todo.isComplete,
                onChanged: (value) {
                  setState(() {
                    // Update frontend
                    todo.isComplete = value!;
                    // TODO: Update backend
                  });
                },
              ),
            ),
            onDismissed: (direction) {
              // Direction tells me if it's left or right (in our case we don't care)
              setState(() {
                // Update frontend
                _todoList.removeAt(index);
                // TODO: Update backend
              });
            },
          );
        },
      ),
    );
  }
}
