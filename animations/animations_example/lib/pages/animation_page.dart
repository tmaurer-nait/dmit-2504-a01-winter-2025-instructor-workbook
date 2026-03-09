import 'package:animations_example/widgets/rainbow_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  // Allows us to link to the device's refresh rate

  late final Animation _animation;
  late final AnimationController _controller;

  var _endVal = 2 * math.pi;

  @override
  void initState() {
    super.initState();

    // Create the controller, link it to this widgets ticker and set the duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = _controller.drive(CurveTween(curve: Curves.elasticOut));

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose(); // Prevent memory leaks
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              // whenever the controller changes, call the new builder
              builder: (context, child) {
                return Transform.rotate(
                  // as the controller changes from 0 to 1 do a full 360 degree rotation
                  angle: _controller.value * 2 * math.pi,
                  child: Text('Rotate', style: TextStyle(fontSize: 30)),
                );
              },
            ),
            SizedBox(height: 100),
            // Tween Animation Builder doesn't need a controller, it needs a tween and duration
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: _endVal),
              duration: Duration(seconds: 5),
              builder: (context, value, widget) {
                return Transform.rotate(
                  angle: value,
                  child: Text('Tween Rotation'),
                );
              },
              onEnd: () => setState(() {
                _endVal = _endVal == 0 ? 2 * math.pi : 0;
              }),
            ),
            SizedBox(height: 100),
            RotationTransition(
              turns: _controller,
              child: Text('Rotation Transition'),
            ),
            SizedBox(height: 100),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_animation.value * 300),
                  child: Text('curved translate'),
                );
              },
            ),
            RainbowButton(child: Text('Button')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat();
          }
        },
      ),
    );
  }
}
