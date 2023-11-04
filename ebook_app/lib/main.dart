import 'package:ebook_app/Screens/DetailScreen.dart';
import 'package:ebook_app/Screens/HomeScreen.dart';
import 'package:ebook_app/Screens/Subject_Display_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/MainScreen.dart';
import 'Screens/Register_or_Chat_Screen.dart';
import 'Screens/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(), //Home(),
    );
  }
}
