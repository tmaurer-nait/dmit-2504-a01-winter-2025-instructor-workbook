import 'package:flutter/material.dart';
import '../widgets/app_nav_bar.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Three')),
      body: const Center(child: Text('Page Three')),
      bottomNavigationBar: const AppNavBar(currentIndex: 2),
    );
  }
}
