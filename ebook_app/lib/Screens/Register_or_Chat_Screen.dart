import 'package:ebook_app/Constants/Colors.dart';
import 'package:ebook_app/Screens/Chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

class Register_or_Chat extends StatefulWidget {
  var book_name;
  Register_or_Chat({required this.book_name});

  @override
  State<Register_or_Chat> createState() => _Register_or_ChatState();
}

class _Register_or_ChatState extends State<Register_or_Chat> {
  @override
  DatabaseReference user_info = FirebaseDatabase.instance.ref('ID');
  var name;
  var email_phn;
  var b_name;
  var check = true;
  @override
  void initState() {
    user_info.onValue.listen((event) {
      setState(() {
        var e = event.snapshot.value as Map;
        name = e['name'];
        email_phn = e['email_or_phn'];
        b_name = widget.book_name;
      });
      check = false;
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (check)
            ? LoadingBar()
            : (name != null)
                ? Chat(
                    name: name,
                    book_name: widget.book_name,
                  )
                : Register_1(
                    user_info: user_info,
                    name: name,
                    b_name: widget.book_name,
                  ));
  }
}

class Register_1 extends StatelessWidget {
  final DatabaseReference user_info;
  var name;
  var b_name;
  Register_1(
      {required this.user_info, required this.name, required this.b_name});
  TextEditingController tx_name = TextEditingController();
  TextEditingController tx_mssg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Container(
            height: h / 1.4,
            width: h / 1.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "YOU HAVE TO REGISTER BEFORE ",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 13,
                      color: Color(0xFFD4AF37),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    " ENTERING TO DISCUSSION",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 13,
                      color: Color(0xFFD4AF37),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "Name:",
                        style: GoogleFonts.dancingScript(
                            color: kBlackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Container(
                          height: 45,
                          width: 270,
                          child: TextField(
                            controller: tx_name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .grey, // Change the color to your desired border color
                                    width:
                                        1.0, // Adjust the width to your desired border width
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .grey, // Change the color to your desired border color
                                    width:
                                        1.0, // Adjust the width to your desired border width
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .blue, // Change the color to your desired border color when focused
                                    width:
                                        1.0, // Adjust the width to your desired border width when focused
                                  ),
                                ),
                                hintText: 'Enter your name...'),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "E-mail / Phone Number:",
                        style: GoogleFonts.dancingScript(
                            color: kBlackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Container(
                            height: 45,
                            width: 270,
                            child: TextField(
                              controller: tx_mssg,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Change the color to your desired border color
                                      width:
                                          1.0, // Adjust the width to your desired border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Change the color to your desired border color
                                      width:
                                          1.0, // Adjust the width to your desired border width
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Change the color to your desired border color when focused
                                      width:
                                          1.0, // Adjust the width to your desired border width when focused
                                    ),
                                  ),
                                  hintText:
                                      'Enter your e-mail or phone number...'),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            )))
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      user_info.set(
                          {"name": tx_name.text, "email_or_phn": tx_mssg.text});
                      tx_name.clear();
                      tx_mssg.clear();
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return Chat(
                          name: name,
                          book_name: b_name,
                        );
                      })));
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/main_page_bg.png'), fit: BoxFit.fill),
        ),
      ),
    );
  }
}

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
