import 'dart:convert';
import 'package:ebook_app/Screens/Subject_Display_Screen.dart';
import 'package:ebook_app/Screens/WebViewReadScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../Constants/Colors.dart';
import '../Widgets/Reading_Card_List_0.dart';
import 'Register_or_Chat_Screen.dart';
import 'Sorry_Screen.dart';

class DetailScreen extends StatefulWidget {
  final String s_result;

  DetailScreen({
    required this.s_result,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondaryDetailScreen(f_result: widget.s_result),
    );
  }
}

class SecondaryDetailScreen extends StatefulWidget {
  final String f_result;
  const SecondaryDetailScreen({required this.f_result});

  @override
  State<SecondaryDetailScreen> createState() => _SecondaryDetailScreenState();
}

class _SecondaryDetailScreenState extends State<SecondaryDetailScreen> {
  String image = '';
  String title = '';
  String author = '';
  String readData = '';
  String publish_date = '';
  String publisher = '';
  int pageCount = 0;
  String description = '';
  bool ok = true;
  bool zok = true;
  var title_again = '';
  Future<void> getResults() async {
    try {
      final url = "https://gutendex.com/books?search=${widget.f_result}";
      final a_url =
          "https://www.googleapis.com/books/v1/volumes?q=${widget.f_result}";
      var response = await http.get(Uri.parse(url));
      var a_response = await http.get(Uri.parse(a_url));

      if (response.statusCode == 200 && a_response.statusCode == 200) {
        var responseData = jsonDecode(response.body)['results'];

        if (responseData != null && responseData.isNotEmpty) {
          setState(() {
            var firstResult = responseData[0];

            image = firstResult['formats']['image/jpeg'] ?? '';
            title = firstResult['title'] ?? '';
            author = firstResult['authors'][0]['name'] ?? '';
            readData = firstResult['formats']['text/html'] ?? '';
            if (title.toString().length > 22) {
              for (int i = 0; i < title.toString().length; i++) {
                if (title[i] != ',') {
                  title_again += title[i];
                } else {
                  break;
                }
              }
            } else {
              title_again = title;
            }
          });
        } else {
          setState(() {
            zok = false;
          });
        }

        var a_responseData = jsonDecode(a_response.body)['items'];

        if (a_responseData != null && a_responseData.isNotEmpty) {
          setState(() {
            var firstAResult = a_responseData[0]['volumeInfo'];

            publish_date = firstAResult['publishedDate'] ?? '(Not Reaveled)';
            publisher = firstAResult['publisher'] ?? '(Not Reaveled)';
            pageCount = firstAResult['pageCount'] as int? ?? 0;
            description = firstAResult['description'] ??
                '(There is no description of this book currently !!!)';

            if (title.isNotEmpty &&
                image.isNotEmpty &&
                author.isNotEmpty &&
                readData.isNotEmpty) {
              ok = false;
            }
          });
        } else {
          setState(() {
            zok = false;
          });
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
      // Handle the error as needed
    }
  }

  @override
  void initState() {
    getResults();
    super.initState();
    print(description);
    print(widget.f_result);
  }

  @override
  Widget build(BuildContext context) {
    print(ok);
    return Scaffold(
        body: (ok == true && zok == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (!zok)
                ? Sorry()
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06),
                          Expanded(
                            // Wrap the Column with Expanded
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3.7,
                              width: MediaQuery.of(context).size.width / 1.10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                           Text(
                                                "Title : ${title_again}",
                                                style: TextStyle(
                                                    color: kProgressIndicator,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                           
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Author: ${author}",
                                              style: GoogleFonts.dancingScript(
                                                  color: kProgressIndicator,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Publisher: ${publisher}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kProgressIndicator,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            "Publish Date: ${publish_date}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kProgressIndicator,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Total Page: ${pageCount}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: kProgressIndicator,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return WebRead(link: readData);
                                              })));
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Center(
                                                child: Text(
                                                  "Read",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Register_or_Chat(
                                                      book_name: title);
                                                }));
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFD4AF37),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Center(
                                                child: Text(
                                                  "Discuss",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Image.network(
                                        image,
                                        height: 130,
                                        width: 110,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/main_page_bg.png"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                                // Wrap the Text with SingleChildScrollView
                                child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Description :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline)),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 5,
                                )),
                                TextSpan(
                                    text: description,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ])),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
