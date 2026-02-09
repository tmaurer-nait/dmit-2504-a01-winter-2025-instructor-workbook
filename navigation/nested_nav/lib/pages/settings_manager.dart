import 'package:flutter/material.dart';
import 'package:nested_nav/pages/settings/option_1.dart';
import 'package:nested_nav/pages/settings/option_2.dart';
import 'package:nested_nav/pages/settings/option_3.dart';
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

      case 'option-1':
        page = Option1Page();
        break;
      case 'option-2':
        page = Option2Page();
        break;
      case 'option-3':
        page = Option3Page();
        break;

      default:
        throw Exception('Unknown route used');
    }

    return MaterialPageRoute(builder: (context) => page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Settings"),
        leading: IconButton(
          onPressed: () {
            // This is the back button for all my settings pages
            // If there is anything left in the sub-navigator stack
            // I want to pop that. Otherwise I want to pop the main stack.
            if (_navigatorKey.currentState!.canPop()) {
              _navigatorKey.currentState!.pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: _onGenerateRoute,
        initialRoute: widget.initialRoute,
      ),
    );
  }
}
