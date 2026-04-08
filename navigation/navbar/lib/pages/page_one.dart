import 'package:flutter/material.dart';
import '../widgets/app_nav_bar.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page One')),
      body: const Center(child: Text('Page One')),
      bottomNavigationBar: const AppNavBar(currentIndex: 0),
    );
  }
}
