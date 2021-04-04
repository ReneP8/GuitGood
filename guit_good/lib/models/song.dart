//not functional yet
class Song {
  int songID;
  int difficulty;
  int length;
  String genre;
  String name;
  String artist;
  String url;

  Song({this.songID, this.difficulty, this.length, this.genre, this.name, this.artist, this.url});

  Map<String, dynamic> toMap() {
    return {
      'songID': songID,
      'difficulty': difficulty,
      'length': length,
      'genre' : genre,
      'name' : name,
      'artist' : artist,
      'url' : url
    };
  }

  // from map to object
  factory Song.fromMap(Map<String, dynamic> json) => new Song(
    songID: json["songID"],
    difficulty: json["difficulty"],
    length: json["length"],
    genre: json["genre"],
    name: json["name"],
    artist: json["artist"],
    url: json["url"],
  );
}

