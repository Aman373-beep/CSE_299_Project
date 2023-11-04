import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:ebook_app/Screens/DetailScreen.dart';
import 'package:ebook_app/Screens/Subject_Display_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'firebase_options.dart';
import '../Constants/Colors.dart';
import '../Widgets/Reading_Card_List_0.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  @override
  DatabaseReference db = FirebaseDatabase.instance.ref('Recent');
  var r_book;
  var r_author;
  var r_ImgLink;
  void initState() {
    // TODO: implement initState
    db.onValue.listen((event) {
      var e = event.snapshot.value as Map;
      r_book = e['book'];
      r_author = e['author'];
      r_ImgLink = e['I_Link'];
    });
    super.initState();
    fetch_data();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    control!.clear();
  }

  @override
  TextEditingController? control = TextEditingController();
  List<String> Subject = [
    'Literature',
    'History',
    'Philosophy',
    'Science',
    'Mathematics',
    'Religion',
    'Social sciences',
    'Arts and music',
    'Travel',
    "Children's books"
  ];
  final url1 = [];
  final url2 = [];
  final url3 = [];
  final url4 = [];
  final url5 = [];
  final book_srch = [];
  var zero = 'Middlemarch';
  var one = 'The Whale';
  var two = 'A Room with a View';
  var three = 'Cranford';
  var four = 'Twenty Years After';
  var five = 'Pride and Prejudice';
  bool isLoaded = false;
  bool pending = false;
  String data = '';
  Future<void> fetch_data() async {
    final url = [
      'https://gutendex.com/books?search=$zero',
      'https://gutendex.com/books?search=$one',
      'https://gutendex.com/books?search=$two',
      'https://gutendex.com/books?search=$three',
      'https://gutendex.com/books?search=$four',
      'https://gutendex.com/books?search=$five'
    ];

    for (var i in url) {
      var response = await http.get(Uri.parse(i));

      if (response.statusCode == 200) {
        setState(() {
          url1.add(
              jsonDecode(response.body)['results'][0]['formats']['image/jpeg']);

          url2.add(
              jsonDecode(response.body)['results'][0]['download_count'] as int);

          url3.add(jsonDecode(response.body)['results'][0]['title']);
          url4.add(
              jsonDecode(response.body)['results'][0]['authors'][0]['name']);
          url5.add(
              jsonDecode(response.body)['results'][0]['formats']['text/html']);
          if (url1.length == 6) {
            isLoaded = true;
          }
        });
      }
    }
  }

  Widget build(BuildContext context) {
    //fetch_image();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                body: (isLoaded == false)
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.topCenter,
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/main_page_bg.png'))),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 20,
                                left: 22,
                                right: 20,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: TextField(
                                      controller: control,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return DetailScreen(
                                                        s_result: control!.text
                                                            .toString());
                                                  }));
                                                  //control!.clear();
                                                });
                                              },
                                              icon: Icon(Icons.search)),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  control!.clear();
                                                });
                                              },
                                              icon: Icon(Icons.delete)),
                                          hintText: 'Search...'),
                                    ),
                                  ),
                                  height: 45,
                                  width: 270,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                )),
                            Positioned(
                              top: 80,
                              left: 27,
                              right: 0,
                              child: Text(
                                "What are you",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Positioned(
                                top: 112,
                                left: 27,
                                right: 0,
                                child: Text("reading today ?",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w600))),
                            Positioned(
                                top: 155,
                                left: 27,
                                right: 0,
                                child: Container(
                                    height: 250,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: url1.length,
                                        itemBuilder: ((context, index) {
                                          return Row(
                                            children: [
                                              Reading_Card(
                                                book_img: url1[index],
                                                downdload_c: url2[index],
                                                title: (index == 1)
                                                    ? "The Whale"
                                                    : url3[index],
                                                author: url4[index],
                                                url: url5[index],
                                              ),
                                              SizedBox(width: 30),
                                            ],
                                          );
                                        })))),
                            Positioned(
                                top: 395,
                                left: 27,
                                right: 0,
                                child: Text('Categories',
                                    style: GoogleFonts.dancingScript(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600))),
                            Positioned(
                              top: 430,
                              left: 27,
                              right: 0,
                              child: Container(
                                  width: double.infinity,
                                  height: 45,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: Subject.length,
                                      itemBuilder: ((context, index) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SubjectScreen(
                                                                subject:
                                                                    Subject[
                                                                        index],
                                                              )));
                                                });
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/bg.png'),
                                                        fit: BoxFit.fill),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: Text(
                                                    Subject[index],
                                                    style: TextStyle(
                                                        color: kBlackColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        );
                                      }))),
                            ),
                            Positioned(
                                top: 500,
                                left: 27,
                                right: 0,
                                child: Row(
                                  children: [
                                    Text(
                                      'Continue',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 23),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'reading...',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                            Positioned(
                                top: 540,
                                left: 23,
                                right: 0,
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(38.5),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 33,
                                        color:
                                            Color(0xFFD3D3D3).withOpacity(.84),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 30, right: 20),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        url3[0],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        url4[0],
                                                        style: TextStyle(
                                                          color:
                                                              kLightBlackColor,
                                                        ),
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: Text(
                                                              "Chapter 2 of 10",
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    kLightBlackColor,
                                                              ),
                                                            ),
                                                          )),
                                                      SizedBox(height: 5),
                                                    ],
                                                  ),
                                                ),
                                                Image.network(
                                                  url1[0],
                                                  width: 50,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .62,
                                          decoration: BoxDecoration(
                                            color: kProgressIndicator,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ))));
  }
}
