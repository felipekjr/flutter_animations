import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool animationIn = false;

  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> doubleAnimation = CurvedAnimation(
    parent: controller,
    curve: Curves.fastOutSlowIn,
  );

  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.elasticIn,
  ));

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        animationIn = !animationIn;
      });
    });
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          children: [
            title('Implicit animations'),
            animatedAlign(),
            animatedContainer(),
            animatedRotation(),
            animatedOpacity(),
            title('Controlled animations'),
            scaleTransition(),
            slideTransition(),
            title('Hero'),
            heroButton()
          ]
        ),
      )),
    );
  }

  Widget title(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: Text(title, style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
    )),
  );

  Widget box() => Container(
    width: 50,
    height: 50,
    color: const Color(0xFFb04863),
  );

  Widget container({required Widget child}) => Container(
    color: Colors.blueGrey[100],
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      alignment: Alignment.center,
      children: [
        child,
      ],
    )
  );

  Widget animatedAlign() => container(child: AnimatedAlign(
    alignment: animationIn ? Alignment.centerRight : Alignment.centerLeft,
    duration: const Duration(seconds: 1),
    curve: Curves.easeIn,
    child: box(),
  ));

  Widget animatedContainer() => container(child: AnimatedContainer(
    alignment: animationIn ? Alignment.centerRight : Alignment.centerLeft,
    height: animationIn ? 50 : 10,
    duration: const Duration(seconds: 1),
    curve: Curves.easeIn,
    child: box(),
  ));

  Widget animatedRotation() => container(child: AnimatedRotation(
    duration: const Duration(seconds: 1),
    curve: Curves.easeIn,
    turns: animationIn ? 1 : 0,
    child: box(),
  ));

  Widget animatedOpacity() => container(child: AnimatedOpacity(
    duration: const Duration(seconds: 1),
    curve: Curves.easeIn,
    opacity: animationIn ? 1 : 0,
    child: box(),
  ));

  Widget scaleTransition() => container(child: ScaleTransition(
    scale: doubleAnimation,
    child: box(),
  ));

  Widget slideTransition() => container(child: SlideTransition(
    position: offsetAnimation,
    child: box(),
  ));

  Widget heroButton() => GestureDetector(
    child: Hero(
      flightShuttleBuilder: _flightShuttleBuilder,
      tag: 'hero-animation',
      child: Container(
        height: 50,
        width: 200,
        color: Colors.blueGrey,
        child: const Center(
          child: Text('Click me!', style: TextStyle(color: Colors.white))
        ),
      ),
    ),
    onTap: () {
      Navigator.of(context).pushNamed('/detail');
    }
  );
}

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}