import 'package:flutter/material.dart';
import 'pages/page_one.dart';
import 'pages/page_two.dart';
import 'pages/page_three.dart';
import 'widgets/app_nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppNavBar.routeOne,
      onGenerateRoute: (settings) {
        final Widget page = switch (settings.name) {
          AppNavBar.routeTwo => const PageTwo(),
          AppNavBar.routeThree => const PageThree(),
          _ => const PageOne(),
        };
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 150),
        );
      },
    );
  }
}
