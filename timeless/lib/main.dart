import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'screens/RegistrationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Timeless',
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: LoginScreen(), // Start with login or check auth state
    );
  }
}