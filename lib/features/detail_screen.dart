import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget  {
  const DetailScreen({ Key? key }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with TickerProviderStateMixin {
  final List randomList = [];
  int lastIndex = 0;
  bool stopTimer = false;
  late Timer myTimer;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animatable<Offset> animation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  );

  @override
  void initState() {
    myTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (!stopTimer) {
        randomList.insert(lastIndex, lastIndex);
        listKey.currentState?.insertItem(lastIndex);
        setState(() {
          lastIndex = lastIndex + 1;
          stopTimer = randomList.length == 5;
        });
      } else {
        myTimer.cancel();
      }
    });
    super.initState();
  }

  void removeItem(int index) {
    randomList.removeAt(index);
    listKey.currentState?.removeItem(index, (_, animation) => animatedContainer(animation, index));
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
        title: const Text('Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Hero(
            tag: 'hero-animation',
            child: Container(
              height: 300,
              color: Colors.blueGrey[300]
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedList(
                key: listKey,
                initialItemCount: randomList.length,
                itemBuilder: (context, index, animation) => animatedContainer(animation, index)
              )
            ),
          )
        ]
      ),
    );
  }

  Widget animatedContainer(Animation animation, int index) => SlideTransition(
    position: animation.drive(this.animation),
    child: GestureDetector(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(top: 5),
        color: const Color(0xFFb04863),
        child: const Center(child: Text('Click to remove', style: TextStyle(color: Colors.white),)),
      ),
      onTap: () => removeItem(index)
   ),
  );
}