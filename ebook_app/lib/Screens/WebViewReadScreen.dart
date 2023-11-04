import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class WebRead extends StatelessWidget {
  late String link;
  WebRead({required this.link});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WebView(
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
