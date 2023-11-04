import 'package:ebook_app/Screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TransitionScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Bitmap.png'), fit: BoxFit.fill)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.39,
            ),
            Text(
              "My Read",
              style: GoogleFonts.dancingScript(
                  fontSize: 34, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      (MaterialPageRoute(builder: (context) {
                        return Main_Screen();
                      })));
                });
              },
              child: Container(
                height: 40,
                width: 180,
                child: Center(
                  child: Text(
                    'Start Reading',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(3, 5),
                        color: Colors.grey,
                        blurRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
