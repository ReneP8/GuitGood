import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guit_good/models/song.dart';
import 'package:guit_good/services/song_service.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  SongService _songService = new SongService();

  Song _song = new Song(difficulty: 3, length: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add new Song')),
        body: SingleChildScrollView(
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text('New Song', style: TextStyle(fontSize: 35)),
                    ),
                    SizedBox(height: 30.0),
                    Text('Title',
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter a title",
                        ),
                        onSaved: (val) => {
                          _song.name = val,
                        },
                        validator: (val) => val.isEmpty ? 'Title is empty' : null,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text('Genre',
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter the genre",
                        ),
                        onSaved: (val) => {
                          _song.genre = val,
                        },
                        validator: (val) => val.isEmpty ? 'Genre is empty' : null,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text('Artist',
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter the artist",
                        ),
                        onSaved: (val) => {
                          _song.artist = val,
                        },
                        validator: (val) =>
                            val.isEmpty ? 'Artist is empty' : null,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text('URL',
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter the url",
                        ),
                        onSaved: (val) => {
                          _song.url = val,
                        },
                        validator: (val) => val.isEmpty ? 'URL is empty' : null,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text('Difficulty',
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    StatefulBuilder(
                      builder: (context, state) => Slider(
                        activeColor: Colors.green,
                        inactiveColor: Colors.black,
                        value: _song.difficulty.toDouble(),
                        onChanged: (val) => {
                          state(() {
                            _song.difficulty = val.round();
                          })
                        },
                        min: 1.0,
                        max: 10.0,
                        divisions: 10,
                        label: _song.difficulty.toString(),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text('Length',
                        style: TextStyle(color: Colors.green, fontSize: 20)),
                    StatefulBuilder(
                      builder: (context, state) => Slider(
                        activeColor: Colors.green,
                        inactiveColor: Colors.black,
                        value: _song.length.toDouble(),
                        onChanged: (val) => {
                          state(() {
                            _song.length = val.round();
                          })
                        },
                        min: 1.0,
                        max: 10.0,
                        divisions: 10,
                        label: _song.length.toString(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 50,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('ADD',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                      color: Colors.green,
                      onPressed: () async {
                        final FormState form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          int result = await this._songService.createSong(_song);
                          if (result != null) {
                            Navigator.of(context).pop();
                          } else if (result == 0) {
                            print("Saving not possible");
                          }
                        }
                      }),
                ),
              ],
            ),
          )),
        ));
  }
}
