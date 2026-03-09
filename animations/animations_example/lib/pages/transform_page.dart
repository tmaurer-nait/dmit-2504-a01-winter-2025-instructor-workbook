import 'package:animations_example/pages/animation_page.dart';
import 'package:flutter/material.dart';
// Needed for pi
import 'dart:math' as math;

class TransformPage extends StatelessWidget {
  const TransformPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transforms Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wrap a widget in a transform to change it
            Transform.rotate(
              angle: 45 * math.pi / 180, // Angle is measured in radians
              child: Text('Rotate this text', style: TextStyle(fontSize: 30)),
            ),
            SizedBox(height: 100),
            Transform.scale(
              scale: 2,
              child: Text('Scale this text', style: TextStyle(fontSize: 30)),
            ),
            SizedBox(height: 100),
            Transform.translate(
              // x and y offset (positive is right,down)
              offset: Offset(50, -500),
              child: Text(
                'Translate this text',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Transform.rotate(
              angle: math.pi,
              child: Transform.scale(
                scaleX: 3,
                child: Transform.translate(
                  offset: Offset(30, -40),
                  child: Text('Rotate, scale, translate'),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AnimationPage()));
        },
      ),
    );
  }
}
