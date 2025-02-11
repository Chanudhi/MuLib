import 'package:flutter/cupertino.dart';
import '../models/song_model.dart';
import '../screens/player_screen.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        song.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(song.artist, style: const TextStyle(fontSize: 14, color: CupertinoColors.systemGrey)),
      leading: const Icon(CupertinoIcons.music_note, size: 28),
      trailing: const Icon(CupertinoIcons.play_circle, size: 24, color: CupertinoColors.activeBlue),
      onTap: () {
        // Navigate to PlayerScreen with selected song
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PlayerScreen(song: song),
          ),
        );
      },
    );
  }
}
