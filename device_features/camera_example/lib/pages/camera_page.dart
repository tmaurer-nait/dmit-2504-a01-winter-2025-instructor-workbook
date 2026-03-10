import 'package:camera_example/pages/photos_page.dart';
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

  Future<XFile?> _takePicture() async {
    // first make sure we're not currently taking a photo
    if (_camController.value.isTakingPicture) return null;

    try {
      var file = await _camController.takePicture();
      // When I take the picture the file automatically gets saved into a local cache
      // We can move it to more permanent storage
      // if we like or just read it from there later on
      return file;
    } catch (e) {
      // If something goes wrong while taking a picture handle that here
    }
    return null;
  }

  @override
  void dispose() {
    // don't forget to dispose controllers to prevent memory leaks
    _camController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Button to get to the photos page
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => PhotosPage()));
            },
            icon: Icon(Icons.photo),
          ),
        ],
      ),
      // Camera preview
      body: Center(child: Expanded(child: CameraPreview(_camController))),
      // Take a picture button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var file = await _takePicture();
          if (file != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Picture saved to ${file.path}')),
            );
          }
        },
      ),
    );
  }
}
