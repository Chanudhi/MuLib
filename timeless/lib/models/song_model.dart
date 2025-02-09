class Song {
  final String id;
  final String title;
  final String artist;
  final String url; // Audio file URL (Firebase Storage or web)
  final Duration duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
    required this.duration,
  });

  // For Firebase data parsing
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      url: json['url'],
      duration: Duration(seconds: json['duration']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'artist': artist,
    'url': url,
    'duration': duration.inSeconds,
  };
}