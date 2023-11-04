import 'package:ebook_app/Constants/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'Message.dart';

class Chat extends StatefulWidget {
  var name;
  var book_name;
  Chat({required this.name, required this.book_name});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late DatabaseReference db;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    db = FirebaseDatabase.instance.ref(widget.book_name);
    db.onChildAdded.listen((event) {
      var e = event.snapshot.value as Map;
      setState(() {
        user_info.add(Message(
            name: e['name'], DateTime: e['Datetime'], mssg: e['message']));
      });
    });
    super.initState();
  }

  void _sendMessage(String message) {
    db.push().set({
      'name': widget.name.toString(),
      'Datetime': '${now.day}-${now.month}-${now.year}',
      'message': message,
    });
    _textEditingController.clear();
  }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.book_name.toString(),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: user_info.length,
                  itemBuilder: (_, int index) {
                    return Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.blue,
                              child: ListTile(
                                leading: Icon(
                                  Icons.tag_faces,
                                  color: Colors.yellow,
                                ),
                                title: Text(
                                  user_info[index].name.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                subtitle: Text(
                                  user_info[index].DateTime.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              user_info[index].mssg,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _textEditingController,
                        onSubmitted: _sendMessage,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Send a message'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () =>
                          _sendMessage(_textEditingController.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
