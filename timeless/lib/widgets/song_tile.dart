import 'package:flutter/cupertino.dart';
import '../models/song_model.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(song.title),
      subtitle: Text(song.artist),
      leading: const Icon(CupertinoIcons.music_note),
      trailing: const Icon(CupertinoIcons.play_circle),
      onTap: () => Navigator.pushNamed(context, '/player', arguments: song),
    );
  }
}