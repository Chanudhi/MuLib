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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _musicService.playSong(widget.song.url);
      } catch (e) {
        _showErrorDialog('Failed to play song: ${e.toString()}');
      }
    });
  }

  @override
  void dispose() {
    _musicService.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Now Playing')),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.music_albums, size: 200),
            StreamBuilder<Duration>(
              stream: _musicService.getPositionStream(),
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                return CupertinoSlider(
                  value: position.inSeconds.toDouble(),
                  min: 0,
                  max: widget.song.duration.inSeconds > 0
                      ? widget.song.duration.inSeconds.toDouble()
                      : 1,
                  onChanged: (value) {
                    if (widget.song.duration.inSeconds > 0) {
                      _musicService.seek(Duration(seconds: value.toInt()));
                    }
                  },
                );
              },
            ),
            StreamBuilder<PlayerState>(
              stream: _musicService.getPlaybackState(),
              builder: (context, snapshot) {
                final isPlaying = snapshot.data?.playing ?? false;
                return CupertinoButton(
                  onPressed:
                      isPlaying ? _musicService.pause : _musicService.resume,
                  child: Icon(
                    isPlaying ? CupertinoIcons.pause : CupertinoIcons.play,
                    size: 40,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MusicService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSong(String url) async {
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
  }

  Stream<Duration> getPositionStream() {
    return _audioPlayer.positionStream;
  }

  Stream<PlayerState> getPlaybackState() {
    return _audioPlayer.playerStateStream;
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

}
