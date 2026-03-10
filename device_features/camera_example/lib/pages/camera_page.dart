import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({required this.cameraDescription, super.key});

  final CameraDescription cameraDescription;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _camController;

  @override
  void initState() {
    super.initState();

    _camController = CameraController(
      widget.cameraDescription,
      ResolutionPreset.max,
    );

    // When initializing the camera controller we can get permissions
    _camController
        .initialize()
        .then((_) {
          if (!mounted) return;
          setState(() {
            // Empty set state
            // Useful for forcing a rerender after camera is initialized
            // Here we could the set camera presets if we wanted
          });
        })
        .catchError((e) {
          if (e is CameraException && e.code == 'CameraAccessDenied') {
            print(e);
            // Decide how to handle no permissions
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Button to get to the photos page
      appBar: AppBar(),
      // Camera preview
      body: Center(child: Expanded(child: CameraPreview(_camController))),
      // Take a picture button
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
