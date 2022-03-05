import 'package:flutter/material.dart';
import 'package:flutter_animations/features/login_screen.dart';
import 'package:flutter_animations/features/splash_screen.dart';

void main() {
  runApp(const FlutterAnimations());
}
class FlutterAnimations extends StatelessWidget {
  const FlutterAnimations({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}