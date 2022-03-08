import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animations/widgets/input.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late RiveAnimationController currentAnimation;
  bool loading = false;
  String currentAnimationName = 'idle';
  Artboard? riveArtboard;
  Map animations = {
    0: 'idle',
    1: 'success', 
    2: 'fail',
    3: 'hands_up',
    4: 'hands_down'
  };

  @override
  void initState() {
    super.initState();
    currentAnimation = SimpleAnimation(currentAnimationName);
    loadRiveArtboard();
  }

  void loadRiveArtboard() {
    rootBundle.load('assets/teddy-login-screen.riv').then(
      (data) async {
        final RiveFile file = RiveFile.import(data);
        final Artboard artboard = file.mainArtboard;
        artboard.addController(currentAnimation);
        setState(() => riveArtboard = artboard);
      },
    );
  }

  void animate(String animation) {
    if (currentAnimationName != animation) {
      if (currentAnimationName == 'hands_up') handsDown();
      setState(() => currentAnimationName = animation);
      riveArtboard?.removeController(currentAnimation);
      setState(() => currentAnimation = SimpleAnimation(animation));
      riveArtboard?.addController(currentAnimation);
    }  
  }

  void handsDown() {
    riveArtboard?.removeController(currentAnimation);
    riveArtboard?.addController(SimpleAnimation(animations[4]));
  }

  Future<void> goToHome() async {
    setState(() => loading = true);
    animate(animations[1]);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => loading = false);
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(213, 226, 234, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    bear(),
                    inputs(),
                  ],
                ),
                const SizedBox(height: 20),
                button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bear() => SizedBox(
    height: 250,
    width: 300,
    child: riveArtboard == null
      ? const SizedBox()
      : Rive(artboard: riveArtboard!),
  );

  Widget inputs() => Container(
    margin: const EdgeInsets.only(top: 250),
    padding: const EdgeInsets.all(20.0),
    width: 400,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blueGrey,
    ),
    child: Column(children: [
      const SizedBox(height: 20),
      Input(
        hint: 'Login',
        onChanged: (String v) {
          animate(animations[1]);
        },
      ),
      const SizedBox(height: 20),
      Input(
        hint: 'Senha',
        hide: true,
        onChanged: (String v) {
          animate(animations[3]);
        },
      )
    ]),
  );

  Widget button() => ElevatedButton(
    style: TextButton.styleFrom(backgroundColor: const Color(0xFFb04863)),
    child: Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Animar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
            )
          ),
          if (loading) ...[
            const SizedBox(width: 10),
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            )
          ]
        ],
      )
    ),
    onPressed: () async {
      if (currentAnimationName == animations[2]) {
        await goToHome();
      } else {
        animate(animations[2]);
      }
    },
  );
}