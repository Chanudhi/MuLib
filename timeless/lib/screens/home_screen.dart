import 'package:flutter/cupertino.dart';
import '../models/song_model.dart';
import '../widgets/song_tile.dart';

class HomeScreen extends StatelessWidget {
  final List<Song> songs = [
    Song(
      id: '1',
      title: 'Sample Song 1',
      artist: 'Artist 1',
      url: 'https://example.com/song1.mp3',
      duration: const Duration(minutes: 3, seconds: 30),
    ),
    // Add more songs
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Library')),
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) => SongTile(song: songs[index]),
      ),
    );
  }
}