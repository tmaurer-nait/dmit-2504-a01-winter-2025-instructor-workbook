import 'package:camera_example/pages/camera_page.dart';
import 'package:flutter/material.dart';

// flutter pub add camera
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // select the default first camera
  List<CameraDescription> cameras = await availableCameras();
  final firstCam = cameras[0];

  runApp(MainApp(cameraDescription: firstCam));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.cameraDescription, super.key});

  final CameraDescription cameraDescription;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CameraPage(cameraDescription: cameraDescription));
  }
}
