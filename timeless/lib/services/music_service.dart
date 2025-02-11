import 'package:just_audio/just_audio.dart';

class MusicService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Play a local file
  Future<void> playLocalSong(String assetPath) async {
    await _audioPlayer.setAsset(assetPath); // Use setAsset for local files
    _audioPlayer.play();
  }

  // Pause the song
  Future<void> pause() => _audioPlayer.pause();

  // Resume the song
  Future<void> resume() => _audioPlayer.play();

  // Seek to a specific position
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  // Dispose the player
  void dispose() => _audioPlayer.dispose();

  // Get the current playback position
  Stream<Duration> getPositionStream() => _audioPlayer.positionStream;

  // Get the playback state (playing/paused)
  Stream<PlayerState> getPlaybackState() => _audioPlayer.playerStateStream;
}