import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool _displayFront;
  bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _displayFront = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Play Game')),
        body: Center(
          child: Container(
              constraints: BoxConstraints.tight(Size.square(200.0)),
              child: _buildFlipAnimation()),
        ));
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() =>_displayFront = !_displayFront),
      child: AnimatedSwitcher(
        transitionBuilder: __transitionBuilder,
        duration: Duration(milliseconds: 600),
        child: _displayFront ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget _buildLayout({Key key, String faceName, Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(faceName, style: TextStyle(fontSize: 30.0)),
      ),
    );
  }

  Widget _buildFront() {
    return _buildLayout(
      key: ValueKey(true),
      backgroundColor: Colors.green,
      faceName: "Song",
    );
  }

  Widget _buildRear() {
    return _buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.green,
      faceName: "Challenge",
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_displayFront) != widget.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
