import 'dart:convert';
import 'package:ebook_app/Screens/Subject_Display_Screen.dart';
import 'package:ebook_app/Screens/WebViewReadScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Sorry extends StatelessWidget {
  const Sorry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sorry , the book you are searching is not avaliable here.",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Lottie.network('https://assets7.lottiefiles.com/packages/lf20_aSv5FwU2Ft.json',height: 200,width: 130)
            ],
          ),
        ),
      ),
    );
  }
}
