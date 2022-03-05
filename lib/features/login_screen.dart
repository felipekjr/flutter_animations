import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late RiveAnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = SimpleAnimation('idle');

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(213, 226, 234, 1),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 500,
            width: 300,
            child: RiveAnimation.asset(
              'teddy-login-screen.riv',
              stateMachines: const ['idle', 'success', 'fail', 'hands_up', 'hands_down'],
              controllers: [controller],
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 400),
            color: Colors.pink, width: 400, height: 200
          )
        ],
      ),
    );
  }
}