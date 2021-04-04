import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guit_good/models/challenge.dart';
import 'package:guit_good/services/challenge_service.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool _displayFront;

  Challenge _challenge = new Challenge();
  ChallengeService _challengeService = new ChallengeService();

  @override
  void initState() {
    super.initState();
    _displayFront = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Play Game')),
      body: FutureBuilder(
        future: _challengeService.getRandomChallenge(),
        builder: (BuildContext context, AsyncSnapshot<Challenge> snapshot) {
          if (snapshot.hasData) {
            _challenge = snapshot.data;
            return Center(
              child: Container(
                  constraints: BoxConstraints.tight(Size.square(300.0)),
                  child: _buildFlipAnimation()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() => _displayFront = !_displayFront),
      child: AnimatedSwitcher(
        transitionBuilder: __transitionBuilder,
        duration: Duration(milliseconds: 600),
        child: _displayFront ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget _buildLayout({Key key, String faceName, Color backgroundColor, String side}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(side.contains('front') ? 'Song' : 'Challenge', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 30.0),
            Text(faceName, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFront() {
    return _buildLayout(
      key: ValueKey(true),
      backgroundColor: Colors.yellow,
      faceName: _challenge.content,
      side: 'front'
    );
  }

  Widget _buildRear() {
    return _buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.green,
      faceName: _challenge.content,
      side: 'rear'
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
