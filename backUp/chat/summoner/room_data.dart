
List<Message> _messages;

class Message {
  String profile;
  String summoner;
  String roomName;
  String rank;
  DateTime time;
  Message(this.profile, this.summoner, this.rank, this.roomName, this.time,);

  static List<Message> getMessages() {
    _messages ??= List.generate(60, (i) => Message(
      "images/api_source/champion_square/Akali.png",      
      "브론즈는 못참지", 
      "왼손은 흑염룡", 
      "랭크: 실버", 
      DateTime.now()
    ));
    return _messages;
  }
}

class GroupMessage {
  List<Message> messages;
  GroupMessage(this.messages);
}


