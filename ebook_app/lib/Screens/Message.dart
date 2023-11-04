class Message {
  String name;
  String DateTime;
  String mssg;
  Message({required this.name, required this.DateTime, required this.mssg});
}
   DateTime now = DateTime.now();
List<Message> user_info = [ Message(name:"Safayat Jabbar",DateTime: "${now.day}-${now.month}-${now.year}",mssg: "This is a dummy message.")];
