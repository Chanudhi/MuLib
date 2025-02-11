class Song {
  final String id;
  final String title;
  final String artist;
  final String url; // Audio file URL (Firebase Storage, web, or local assets)
  final Duration duration;
  final bool isLocal; // Indicates if the song is stored locally

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
    required this.duration,
    this.isLocal = false, // Default to false (online storage)
  });

  // For Firebase data parsing
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Unknown Title',
      artist: json['artist'] ?? 'Unknown Artist',
      url: json['url'] ?? '',
      duration: Duration(seconds: (json['duration'] ?? 0).toInt()), // Ensure integer type
      isLocal: json['isLocal'] ?? false, // Handle missing field gracefully
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'artist': artist,
    'url': url,
    'duration': duration.inSeconds,
    'isLocal': isLocal,
  };

  // Factory constructor for local asset songs
  factory Song.fromAsset(String fileName, String title, String artist, Duration duration) {
    return Song(
      id: fileName.split('.').first, // Extract filename without extension
      title: title,
      artist: artist,
      url: 'assets/$fileName', // Reference the local asset
      duration: duration,
      isLocal: true, // Mark as local
    );
  }
}

// Example usage: Creating songs from assets
List<Song> localSongs = [
  Song.fromAsset('Cold Heart.mp3', 'Cold Heart', 'Artist Name', Duration(minutes: 3, seconds: 45)),
  Song.fromAsset('Boom Boom Bass.mp3', 'Boom Boom Bass', 'Artist Name', Duration(minutes: 4, seconds: 10)),
  Song.fromAsset('Clover.mp3', 'Clover', 'Artist Name', Duration(minutes: 3, seconds: 30)),
  Song.fromAsset('Designer.mp3', 'Designer', 'Artist Name', Duration(minutes: 3, seconds: 55)),
  Song.fromAsset('Drunk Dazed.mp3', 'Drunk Dazed', 'Artist Name', Duration(minutes: 3, seconds: 50)),
  Song.fromAsset('Impossible.mp3', 'Impossible', 'Artist Name', Duration(minutes: 4, seconds: 15)),
  Song.fromAsset('Lucky.mp3', 'Lucky', 'Artist Name', Duration(minutes: 3, seconds: 40)),
  Song.fromAsset('Time Lapse.mp3', 'Time Lapse', 'Artist Name', Duration(minutes: 4, seconds: 5)),
];
