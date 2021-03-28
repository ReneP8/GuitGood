import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guit_good/screens/create.dart';
import 'package:guit_good/screens/game.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Game()),
                    );
                  },
                  icon: Icon(Icons.play_arrow),
                  label: Text('Play Game')),
              SizedBox(height: 20.0),
              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Create()),
                    );
                  },
                  icon: Icon(Icons.add_box),
                  label: Text('Add Song')),
            ],
          ),
        ));
  }
}
