import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to track authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get the currently signed-in user
  User? get currentUser => _auth.currentUser;

  // Sign up with email/password
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return user if successful
    } on FirebaseAuthException catch (e) {
      print("Sign-up error: ${e.message}");
      return null;
    }
  }

  // Sign in with email/password
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");
      return null;
    }
  }


  // Sign out
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut(); // Sign out from Google
      await _auth.signOut(); // Sign out from Firebase
    } catch (e) {
      print("Logout error: $e");
    }
  }
}
