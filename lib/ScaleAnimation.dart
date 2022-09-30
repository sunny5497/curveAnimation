import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({Key key}) : super(key: key);

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animatioY;
  double size = 1;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    animatioY = Tween(begin: 900.0, end: 0.0).animate(controller);
    Future.delayed(Duration(milliseconds: 900), () {
      controller.forward();
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          size = .3;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (ctx, widget) {
          return Transform.translate(
              offset: Offset(0, animatioY.value),
              child: AnimatedScale(
                duration: Duration(milliseconds: 900),
                scale: size,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ));
        });
  }
}
