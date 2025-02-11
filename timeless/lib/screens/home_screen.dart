import 'package:flutter/cupertino.dart';
import '../models/song_model.dart';
import '../widgets/song_tile.dart';

class HomeScreen extends StatelessWidget {
  final List<Song> songs = [
    Song(
      id: '1',
      title: 'Cold Heart',
      artist: 'Beakhyun',
      url: '..assests/Cold Heart.mp3',
      duration: const Duration(minutes: 3, seconds: 45),
    ),
    Song(
      id: '2',
      title: 'Boom Boom Bass',
      artist: 'RIIZE',
      url: '..assests/Boom Boom Bass.mp3',
      duration: const Duration(minutes: 4, seconds: 10),
    ),  
    Song(
      id: '3',
      title: 'Clover',
      artist: 'Chanyeol',
      url: '..assests/Clover.mp3',
      duration: const Duration(minutes: 3, seconds: 30),
    ),
    Song( 
      id: '4',
      title: 'Designer',
      artist: 'NCT 127',
      url: '..assests/Designer.mp3',
      duration: const Duration(minutes: 3, seconds: 55),
    ),
    Song(
      id: '5',
      title: 'Drunk Dazed',
      artist: 'ENHYPEN',
      url: '..assests/Drunk Dazed.mp3',
      duration: const Duration(minutes: 3, seconds: 50),
    ),
    Song(id: '6', title: 'Impossible', 
    artist: 'RIIZE',
    url: '..assests/Impossible.mp3',
    duration: const Duration(minutes: 4, seconds: 15),
    ),
    Song(id: '7', 
    title: 'Lucky',
    artist: 'RIIZE',  
    url: '..assests/Lucky.mp3', 
    duration: const Duration(minutes: 3, seconds: 40),
    ),
    Song(id: '8',
    title: 'Time Lapse',  
    artist: 'NCT 127',  
    url: '..assests/Time Lapse.mp3',  
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
        itemBuilder: (context, index) => SongTile(song: songs[index]),
      ),
    );
  }
}