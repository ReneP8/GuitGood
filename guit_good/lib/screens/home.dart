import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guit_good/models/Setting.dart';
import 'package:guit_good/providers/Database.dart';
import 'package:guit_good/screens/create.dart';
import 'package:guit_good/screens/game.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Setting _settings = new Setting();
  DatabaseProvider _databaseProvider = DatabaseProvider.db;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              _gamePresets();
            },
          )
        ]),
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

  void _gamePresets() {
    showDialog(
        context: context,
        builder: (BuildContext context) => FutureBuilder(
            future: _databaseProvider.getSettings(),
            builder: (context, AsyncSnapshot<Setting> snapshot) {
              if (snapshot.hasData) {
                _settings = snapshot.data;
                return SimpleDialog(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Row(
                    children: [
                      Text('Game Settings'),
                      Spacer(),
                      IconButton(
                          icon:
                              Icon(Icons.cancel, size: 25, color: Colors.grey),
                          onPressed: () => Navigator.pop(context))
                    ],
                  ),
                  children: [
                    Divider(color: Colors.green, height: 2),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                Text('Difficulty',
                                    style: TextStyle(color: Colors.green)),
                                StatefulBuilder(
                                  builder: (context, state) => Slider(
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.black,
                                    value: _settings.difficulty.toDouble(),
                                    onChanged: (val) => {
                                      state(() {
                                        _settings.difficulty = val.round();
                                      })
                                    },
                                    min: 1.0,
                                    max: 10.0,
                                    divisions: 10,
                                    label: _settings.difficulty.toString(),
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text('Length',
                                    style: TextStyle(color: Colors.green)),
                                StatefulBuilder(
                                  builder: (context, state) => Slider(
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.black,
                                    value: _settings.length.toDouble(),
                                    onChanged: (val) => {
                                      state(() {
                                        _settings.length = val.round();
                                      })
                                    },
                                    min: 1.0,
                                    max: 10.0,
                                    divisions: 10,
                                    label: _settings.length.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width, height: 30),
                    SizedBox(
                      height: 40,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.green,
                          onPressed: () async {
                            final FormState form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              await this
                                  ._databaseProvider
                                  .updateSetting(_settings);
                              Navigator.of(context).pop();
                            }
                          }),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
