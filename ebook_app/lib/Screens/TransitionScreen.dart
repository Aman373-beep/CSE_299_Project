import 'dart:async';

import 'package:ebook_app/Screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Transition extends StatefulWidget {
  const Transition({super.key});

  @override
  State<Transition> createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Main_Screen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CircularProgressIndicator(),
            Offstage(
              offstage: _isLoading,
              child: Main_Screen(),
            ),
          ],
        ),
      ),
    );
  }
}
