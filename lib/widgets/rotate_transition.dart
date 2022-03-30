import 'package:flutter/material.dart';

class RotateTransition extends AnimatedWidget {
  final Animation animation;
  final Widget child;

  const RotateTransition({
     Key? key,
     required this.animation,
     required this.child,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value * -0.6,
      child: child,
    );
  }
}