import 'package:flutter/material.dart';

import 'features/home_screen.dart';
import 'features/login_screen.dart';
import 'features/splash_screen.dart';
import 'features/detail_screen.dart';

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
      home: const SplashScreen(),
      routes: {
        '/login': (BuildContext context) => const LoginScreen(),
        '/home': (BuildContext context) => const HomeScreen(),
        '/detail': (BuildContext context) => const DetailScreen(),
      },
    );
  }
}