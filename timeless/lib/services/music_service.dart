import 'package:just_audio/just_audio.dart';

class MusicService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Play a local song
  Future<void> playLocalSong(String assetPath) async {
    try {
      await _audioPlayer.setAsset(assetPath); // Load local file
      _audioPlayer.play();
    } catch (e) {
      print("Error playing song: $e");
    }
  }

  // Pause the song
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print("Error pausing song: $e");
    }
  }

  // Resume the song
  Future<void> resume() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
      print("Error resuming song: $e");
    }
  }

  // Seek to a specific position
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print("Error seeking position: $e");
    }
  }

  // Set volume (0.0 - 1.0)
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
    } catch (e) {
      print("Error setting volume: $e");
    }
  }

  // Enable or disable looping
  Future<void> setLooping(bool isLooping) async {
    try {
      _audioPlayer.setLoopMode(
        isLooping ? LoopMode.one : LoopMode.off,
      );
    } catch (e) {
      print("Error setting loop mode: $e");
    }
  }

  // Get the current playback position
  Stream<Duration> getPositionStream() => _audioPlayer.positionStream;

  // Get the playback state (playing/paused)
  Stream<PlayerState> getPlaybackState() => _audioPlayer.playerStateStream;

  // Dispose of the player
  void dispose() {
    _audioPlayer.dispose();
  }
}
