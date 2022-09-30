import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/ScaleAnimation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
      home: MyHomePage(
        title: "",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

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
            BallWidget(
              spacing: 0,
            ),
            BallWidget(
              spacing: 40,
            ),
            BallWidget(
              spacing: 80,
            ),
            BallWidget(
              spacing: MediaQuery.of(context).size.width - 120,
            ),
            BallWidget(
              spacing: MediaQuery.of(context).size.width - 80,
            ),
            BallWidget(
              spacing: MediaQuery.of(context).size.width - 40,
            ),
          ],
        ));
  }
}

class BallWidget extends StatefulWidget {
  bool alignRight = false;
  double spacing;
  double width;
  BallWidget({this.alignRight, this.spacing, Key key}) : super(key: key) {
    this.width = 40;
  }

  @override
  State<BallWidget> createState() => _BallWidgetState();
}

class _BallWidgetState extends State<BallWidget> {
  Offset offset = const Offset(0.0, 0.0);
  Offset lastoffset = const Offset(0.0, 0.0);
  Animatable tween = Tween(begin: 0, end: 1).chain(
      CurveTween(curve: Curves.easeOut)
          .chain(CurveTween(curve: Curves.easeOut)));
  var t = 0.0;
  var val = 0.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -val * SineCurve().transformInternal(t),
      bottom: 0,
      left:t * getWidth(context)==0? widget.spacing + t * getWidth(context):t * getWidth(context),
      
      child: GestureDetector(
        onHorizontalDragUpdate: (value) {
          if (value.primaryDelta > 0) {
            if ((value.globalPosition.dx - offset.dx) > 10) {
              if (t < 0.9) {
                t = t + .01;

                val = -SineCurve().transformInternal(t) *
                   getWidth(context);

                setState(() {
                  offset = Offset(t * getWidth(context),
                      val * SineCurve().transformInternal(t));
                });
              }
            }
          } else {
            if (t > 0.0) {
              if ((value.globalPosition.dx - offset.dx).abs() > 10) {
                t = t - .01;

                val = -SineCurve().transformInternal(t) *
                   getWidth(context);

                setState(() {
                  offset = Offset(t * getWidth(context),
                      val * SineCurve().transformInternal(t));
                });
              }
            }
          }

          // setState(() {
          //   lastoffset = value.localPosition;
          // });
        },
        child: Container(
          height: widget.width,
          width: widget.width,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
}

class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 1});

  // t = x
  @override
  double transformInternal(double t) {
    var val = sin(1.55 * t) * .50;
    return val; //f(x)
  }
}
