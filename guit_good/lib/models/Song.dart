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
}

