import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';
import '../services/music_service.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final MusicService _musicService = MusicService();

  @override
  void initState() {
    super.initState();
    _musicService.playSong(widget.song.url);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Now Playing')),
      child: Column(
        children: [
          const Icon(CupertinoIcons.music_albums, size: 200),
          StreamBuilder<Duration>(
            stream: _musicService.getPositionStream(),
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              return CupertinoSlider(
                value: position.inSeconds.toDouble(),
                min: 0,
                max: widget.song.duration.inSeconds.toDouble(),
                onChanged: (value) => _musicService.seek(Duration(seconds: value.toInt())),
              );
            },
          ),
          StreamBuilder<PlayerState>(
            stream: _musicService.getPlaybackState(),
            builder: (context, snapshot) {
              final isPlaying = snapshot.data?.playing ?? false;
              return CupertinoButton(
                child: Icon(isPlaying ? CupertinoIcons.pause : CupertinoIcons.play),
                onPressed: isPlaying ? _musicService.pause : _musicService.resume,
              );
            },
          ),
        ],
      ),
    );
  }
}