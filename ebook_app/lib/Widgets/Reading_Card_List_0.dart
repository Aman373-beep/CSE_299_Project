import 'dart:convert';

import 'package:ebook_app/Screens/DetailScreen.dart';
import 'package:ebook_app/Screens/WebViewReadScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../Constants/Colors.dart';
import '../Constants/Rating_Count.dart';

class Reading_Card extends StatelessWidget {
  late String book_img;
  late String title;
  late String author;
  int downdload_c = 0;
  late String url;
  var ratings = '';
  Reading_Card(
      {required this.book_img,
      required this.downdload_c,
      required this.title,
      required this.author,
      required this.url});

  @override
  Widget build(BuildContext context) {
    print(book_img);
    String ratings = (downdload_c <= 110000) ? high_rating() : low_rating();
    return Container(
        height: 220,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 9),
                blurRadius: 35,
                color: kShadowColor,
              ),
            ],
            borderRadius: BorderRadius.circular(29)),
        child: Stack(children: [
          Positioned(
              top: 10,
              left: -75,
              right: 0,
              child: Image.network(
                book_img,
                height: 110,
                width: 110,
              )),
          Positioned(
              top: 20,
              right: -135,
              left: 0,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(3, 7),
                          blurRadius: 20,
                          color: Color(0xFD3D3D3).withOpacity(.9),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: kIconColor,
                          size: 15,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "$ratings",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Positioned(
              top: 145,
              left: -55,
              right: 0,
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              )),
          Positioned(
              top: 170,
              left: -90,
              right: 0,
              child: Column(
                children: [
                  Text(
                    author,
                    style: GoogleFonts.dancingScript(
                        color: Colors.black, fontSize: 15),
                  ),
                ],
              )),
          Positioned(
              top: 185,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return DetailScreen(
                          s_result: title,
                        );
                      })));
                    },
                    child: Container(
                      height: 35,
                      width: 101,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Text('Details'),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WebRead(link: url);
                      }));
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: kBlackColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(29),
                          bottomRight: Radius.circular(29),
                        ),
                      ),
                      child: Text(
                        'Read',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
                ],
              ))
        ]));
  }
}
