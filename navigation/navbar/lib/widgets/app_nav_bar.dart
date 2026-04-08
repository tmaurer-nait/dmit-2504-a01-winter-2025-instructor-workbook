import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  static const String routeOne = '/one';
  static const String routeTwo = '/two';
  static const String routeThree = '/three';

  final int currentIndex;

  const AppNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    final route = switch (index) {
      0 => routeOne,
      1 => routeTwo,
      2 => routeThree,
      _ => routeOne,
    };
    Navigator.pushNamed(context, route);
    // Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: 'One'),
        BottomNavigationBarItem(icon: Icon(Icons.looks_two), label: 'Two'),
        BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: 'Three'),
      ],
    );
  }
}
