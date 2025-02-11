import 'package:flutter/cupertino.dart';
import '../models/song_model.dart';
import '../widgets/song_tile.dart';
import 'player_screen.dart'; // Import PlayerScreen for navigation

class HomeScreen extends StatelessWidget {
  final List<Song> songs = [
    Song(
      id: '1',
      title: 'Cold Heart',
      artist: 'Baekhyun',
      url: 'assets/Cold Heart.mp3',
      duration: const Duration(minutes: 3, seconds: 45),
    ),
    Song(
      id: '2',
      title: 'Boom Boom Bass',
      artist: 'RIIZE',
      url: 'assets/Boom Boom Bass.mp3',
      duration: const Duration(minutes: 4, seconds: 10),
    ),  
    Song(
      id: '3',
      title: 'Clover',
      artist: 'Chanyeol',
      url: 'assets/Clover.mp3',
      duration: const Duration(minutes: 3, seconds: 30),
    ),
    Song( 
      id: '4',
      title: 'Designer',
      artist: 'NCT 127',
      url: 'assets/Designer.mp3',
      duration: const Duration(minutes: 3, seconds: 55),
    ),
    Song(
      id: '5',
      title: 'Drunk Dazed',
      artist: 'ENHYPEN',
      url: 'assets/Drunk Dazed.mp3',
      duration: const Duration(minutes: 3, seconds: 50),
    ),
    Song(
      id: '6', 
      title: 'Impossible', 
      artist: 'RIIZE',
      url: 'assets/Impossible.mp3',
      duration: const Duration(minutes: 4, seconds: 15),
    ),
    Song(
      id: '7', 
      title: 'Lucky',
      artist: 'RIIZE',  
      url: 'assets/Lucky.mp3', 
      duration: const Duration(minutes: 3, seconds: 40),
    ),
    Song(
      id: '8',
      title: 'Time Lapse',  
      artist: 'NCT 127',  
      url: 'assets/Time Lapse.mp3',  
      duration: const Duration(minutes: 3, seconds: 35),
    )
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Library')),
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => PlayerScreen(song: song),
                ),
              );
            },
            child: SongTile(song: song),
          );
        },
      ),
    );
  }
}
