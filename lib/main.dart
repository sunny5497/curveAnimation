import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            const Center(
              child: Divider(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BallWidget(),
                  const BallWidget(),
                  const BallWidget(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BallWidget(),
                  const BallWidget(),
                  const BallWidget(),
                ],
              ),
            ),
          ],
        ));
  }
}

class BallWidget extends StatefulWidget {
  const BallWidget({Key? key}) : super(key: key);

  @override
  State<BallWidget> createState() => _BallWidgetState();
}

class _BallWidgetState extends State<BallWidget> {
  Offset offset = const Offset(0.0, 0.0);
  Offset lastoffset = const Offset(0.0, 0.0);
  Animatable tween = Tween(begin: 0, end: 0).chain(
      CurveTween(curve: Curves.easeOut)
          .chain(CurveTween(curve: Curves.easeOut)));
  var t = 0.0;
  var val = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (value) {
        if (t < 0.9) {
          t = t + .01;

          val = -SineCurve().transformInternal(t) * MediaQuery.of(context).size.width;

          setState(() {
            offset = Offset(t * MediaQuery.of(context).size.width, val * SineCurve().transformInternal(t));
          });
        }
        // setState(() {
        //   lastoffset = value.localPosition;
        // });
      },
      child: Transform.translate(
        offset: offset,
        child: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 1});

  // t = x
  @override
  double transformInternal(double t) {
    var val = sin(t);
    return val; //f(x)
  }
}
