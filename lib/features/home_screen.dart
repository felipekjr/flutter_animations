import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(213, 226, 234, 1),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blueGrey,
        actions:  const [

        ]
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          
        ),
      )),
    );
  }
}