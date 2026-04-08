import 'package:flutter/material.dart';
import '../widgets/app_nav_bar.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Two')),
      body: const Center(child: Text('Page Two')),
      bottomNavigationBar: const AppNavBar(currentIndex: 1),
    );
  }
}
