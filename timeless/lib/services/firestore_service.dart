import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Singleton pattern
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 Add a new user to Firestore
  Future<void> addUser(String userId, String email) async {
    try {
      await _db.collection('users').doc(userId).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  // 🔹 Get user data
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUser(String userId) async {
    try {
      return await _db.collection('users').doc(userId).get();
    } catch (e) {
      print("Error getting user: $e");
      return null;
    }
  }

  // 🔹 Add a new song
  Future<void> addSong(String songId, String title, String artist, String url, int duration) async {
    try {
      await _db.collection('songs').doc(songId).set({
        'title': title,
        'artist': artist,
        'url': url,
        'duration': duration, // in seconds
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding song: $e");
    }
  }

  // 🔹 Fetch all songs
  Future<List<Map<String, dynamic>>> getAllSongs() async {
    try {
      final snapshot = await _db.collection('songs').orderBy('createdAt', descending: true).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching songs: $e");
      return [];
    }
  }

  // 🔹 Add a playlist
  Future<void> addPlaylist(String userId, String playlistName, List<String> songIds) async {
    try {
      await _db.collection('users').doc(userId).collection('playlists').add({
        'name': playlistName,
        'songs': songIds,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding playlist: $e");
    }
  }

  // 🔹 Fetch playlists for a user
  Future<List<Map<String, dynamic>>> getUserPlaylists(String userId) async {
    try {
      final snapshot = await _db.collection('users').doc(userId).collection('playlists').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching playlists: $e");
      return [];
    }
  }

  // 🔹 Delete a song
  Future<void> deleteSong(String songId) async {
    try {
      await _db.collection('songs').doc(songId).delete();
    } catch (e) {
      print("Error deleting song: $e");
    }
  }

  // 🔹 Delete a playlist
  Future<void> deletePlaylist(String userId, String playlistId) async {
    try {
      await _db.collection('users').doc(userId).collection('playlists').doc(playlistId).delete();
    } catch (e) {
      print("Error deleting playlist: $e");
    }
  }
}
