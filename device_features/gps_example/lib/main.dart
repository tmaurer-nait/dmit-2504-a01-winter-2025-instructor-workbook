import 'package:flutter/material.dart';

// flutter pub add geolocator
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Position? _position;

  // Requests permissions if needed, and then gets the user's position
  Future<Position> _determinePosition() async {
    // Whether the device currently supports location services
    bool serviceEnabled;
    // Whether this app is allowed to use location services
    LocationPermission permission;

    // Check services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service is disabled on this device');
    }

    permission = await Geolocator.checkPermission();
    // If we don't have permission then ask for it
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // If they still don't give us access, throw an error
      if (permission == LocationPermission.denied) {
        // Here we could re-ask, disable that part of the app, etc.
        // Up to us how we handle it
        return Future.error('Location Permissions are denied');
      }
    }

    // If after asking for permissions it's permanently denied throw an error
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // If no errors are thrown, then we have permission and can get location
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Location: ${_position ?? 'unknown'}'),
              ElevatedButton(
                onPressed: () async {
                  final temp = await _determinePosition();
                  setState(() {
                    _position = temp;
                  });
                },
                child: Text('Get location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
