import 'dart:async';
import 'dart:convert';

import 'package:ebook_app/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../DataModel/Gutendex_dm.dart';
import 'DetailScreen.dart';
import 'WebViewReadScreen.dart';

class Result {
  Result({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  int id;
  String title;
  List<Author> authors;
  List<dynamic> translators;
  List<String> subjects;
  List<dynamic> bookshelves;
  List<String> languages;
  bool copyright;
  String mediaType;
  Formats formats;
  int downloadCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        authors:
            List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        translators: List<dynamic>.from(json["translators"].map((x) => x)),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        bookshelves: List<dynamic>.from(json["bookshelves"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "translators": List<dynamic>.from(translators.map((x) => x)),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats.toJson(),
        "download_count": downloadCount,
      };
}

class Author {
  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  String name;
  int birthYear;
  int deathYear;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
      };
}

class Formats {
  Formats({
    required this.applicationXMobipocketEbook,
    required this.applicationEpubZip,
    required this.textHtml,
    required this.applicationOctetStream,
    required this.imageJpeg,
    required this.textPlain,
    required this.textPlainCharsetUsAscii,
    required this.applicationRdfXml,
  });

  String applicationXMobipocketEbook;
  String applicationEpubZip;
  String textHtml;
  String applicationOctetStream;
  String imageJpeg;
  String textPlain;
  String textPlainCharsetUsAscii;
  String applicationRdfXml;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        applicationEpubZip: json["application/epub+zip"],
        textHtml: json["text/html"],
        applicationOctetStream: json["application/octet-stream"],
        imageJpeg: json["image/jpeg"],
        textPlain: json["text/plain"],
        textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
        applicationRdfXml: json["application/rdf+xml"],
      );

  Map<String, dynamic> toJson() => {
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/epub+zip": applicationEpubZip,
        "text/html": textHtml,
        "application/octet-stream": applicationOctetStream,
        "image/jpeg": imageJpeg,
        "text/plain": textPlain,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
        "application/rdf+xml": applicationRdfXml,
      };
}

class SubjectScreen extends StatefulWidget {
  final String subject;

  SubjectScreen({required this.subject});

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  Future<dynamic> fetchBooksBySubject() async {
    final url = 'https://gutendex.com/books?topic=${widget.subject}';
    final response = await http.get(Uri.parse(url));

    return jsonDecode(response.body)['results'];
  }

  @override
  void initState() {
    fetchBooksBySubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
              future: fetchBooksBySubject(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final res = snapshot.data;
                    final List l = res as List;
                    return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/bg.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: GridView.builder(
                          itemCount: l.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.53,
                            crossAxisCount: 2,
                            //crossAxisSpacing: 8,
                          ),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                height: 220,
                                width: 210,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Image.network(
                                        res[index]['formats']['image/jpeg'],
                                        height: 155,
                                        width: 125,
                                      ),
                                      SizedBox(height: 10),
                                      Center(
                                        child: Text(
                                          res[index]['title'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child: Text(res[index]['authors'][0]
                                              ['name'])),
                                      SizedBox(
                                        height: 78,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return DetailScreen(
                                                    s_result: res[index]
                                                        ['title']);
                                              })));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              alignment: Alignment.center,
                                              child: Text('Details'),
                                            ),
                                          ),
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return WebRead(
                                                    link: res[index]['formats']
                                                        ['text/html']);
                                              }));
                                            },
                                            child: Container(
                                              height: 35,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                color: kBlackColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(28),
                                                  bottomRight:
                                                      Radius.circular(28),
                                                ),
                                              ),
                                              child: Text(
                                                'Read',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Sorry error in your API'),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })),
        ),
      ),
    );
  }
}
