//not functional yet
class Song {
  final int songID;
  final int difficulty;
  final int length;
  final String genre;
  final String name;
  final String artist;
  final String url;

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

