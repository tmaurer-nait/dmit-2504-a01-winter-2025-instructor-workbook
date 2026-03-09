import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

class RainbowButton extends StatefulWidget {
  const RainbowButton({
    super.key,
    required this.child,
    this.onLongPress,
    this.onPressed,
  });

  final Function? onPressed;
  final Function? onLongPress;
  final Widget child;

  @override
  State<RainbowButton> createState() => _RainbowButtonState();
}

class _RainbowButtonState extends State<RainbowButton>
    with SingleTickerProviderStateMixin {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = Colors.pink;

    Timer.periodic(Duration(seconds: 6), (timer) {
      setState(() {
        _color = Color(
          (0xFFFFFF * math.Random().nextDouble()).toInt(),
        ).withValues(alpha: 1.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(end: _color),
      duration: Duration(seconds: 5),
      child: widget.child,
      builder: (_, Color? color, child) {
        return ElevatedButton(
          onPressed: () {
            widget.onPressed?.call();
          },
          onLongPress: () {
            widget.onLongPress?.call();
          },
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: child,
        );
      },
    );
  }
}
