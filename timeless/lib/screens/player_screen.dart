import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final MusicService _musicService = MusicService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    setState(() => _isLoading = true);
    try {
      await _musicService.playSong(widget.song.url);
      print('Playing: ${widget.song.title}');
    } catch (e) {
      print('Error playing song: ${e.toString()}');
      _showErrorDialog('Failed to play song: ${e.toString()}');
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _musicService.stop(); // Stop playback before disposing
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
      navigationBar: CupertinoNavigationBar(middle: Text(widget.song.title)),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.music_albums, size: 200),
            const SizedBox(height: 10),
            Text(widget.song.title, style: const TextStyle(fontSize: 20)),
            Expanded(
              child: StreamBuilder<Duration>(
                stream: _musicService.getPositionStream(),
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  return CupertinoSlider(
                    value: position.inSeconds.toDouble(),
                    min: 0,
                    max: widget.song.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _musicService.seek(Duration(seconds: value.toInt()));
                    },
                  );
                },
              ),
            ),
            StreamBuilder<PlayerState>(
              stream: _musicService.getPlaybackState(),
              builder: (context, snapshot) {
                final isPlaying = snapshot.data?.playing ?? false;
                return CupertinoButton(
                  onPressed: isPlaying
                      ? _musicService.pause
                      : _musicService.resume,
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
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print('Error initializing player: ${e.toString()}');
    }
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

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
