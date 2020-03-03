import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:animator/animator.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;
  bool _first = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          _first = !_first;
        });
      },
      child: Column(
        children: <Widget>[
          AnimatedContainer(
            width: selected ? 200.0 : 100.0,
            height: selected ? 100.0 : 200.0,
            color: selected ? Colors.red : Colors.blue,
            alignment:
                selected ? Alignment.center : AlignmentDirectional.topCenter,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: FlutterLogo(size: 75),
          ),
          AnimatedCrossFade(
            duration: const Duration(seconds: 1),
            firstChild: const FlutterLogo(
                style: FlutterLogoStyle.horizontal, size: 100.0),
            secondChild:
                const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
            crossFadeState:
                _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          Animator(
              tweenMap: {
                "opacity": Tween<double>(begin: 0, end: 1),
                "translation":
                    Tween<Offset>(begin: Offset.zero, end: Offset(4, 0)),
                "rotation": Tween<double>(begin: 0, end: 4 * math.pi)
              },
              duration: Duration(seconds: 1),
              curve: Curves.easeIn,
              builderMap: (anim) => FadeTransition(
                  opacity: anim["opacity"],
                  child: FractionalTranslation(
                    translation: anim["translation"].value,
                    child: Transform.rotate(
                      angle: anim["rotation"].value,
                      child: FlutterLogo(
                        size: 50,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
