import 'package:flutter/material.dart';
import 'package:nested_nav/pages/settings/settings_home_page.dart';

// This widget acts as a hub to route between all of our settings sub pages
class SettingsManager extends StatefulWidget {
  // We are simply going to pass this through to our Navigator
  final String initialRoute;

  const SettingsManager({super.key, required this.initialRoute});

  @override
  State<SettingsManager> createState() => _SettingsManagerState();
}

class _SettingsManagerState extends State<SettingsManager> {
  // I need a way to access this child Navigator when I try to pop
  // Therefore I will create the following key variable
  final _navigatorKey = GlobalKey<NavigatorState>();

  // Defining it here as a named function instead of below as an anonymous
  // function for demonstration purposes. Either is acceptable.
  // Same as in MainApp - this function takes in a route request,
  // and returns a route
  Route _onGenerateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case 'settings-home':
        page = SettingsHomePage();
        break;
      default:
        throw Exception('Unknown route used');
    }

    return MaterialPageRoute(builder: (context) => page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: _onGenerateRoute,
        initialRoute: widget.initialRoute,
      ),
    );
  }
}
