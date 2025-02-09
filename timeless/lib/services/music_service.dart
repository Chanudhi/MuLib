import 'package:just_audio/just_audio.dart';

class MusicService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSong(String url) async {
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
  }

  Future<void> pause() => _audioPlayer.pause();
  Future<void> resume() => _audioPlayer.play();

  Stream<Duration> getPositionStream() => _audioPlayer.positionStream;
  Stream<PlayerState> getPlaybackState() => _audioPlayer.playerStateStream;
}