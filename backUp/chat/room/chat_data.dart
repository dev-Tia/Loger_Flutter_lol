import 'dart:io';
import 'dart:math';

const String kMyAvatar = 'images/api_source/champion_square/Ahri.png';
const String kMyName = '나 님';

List<String> _chatDetails = [
  '우서?','1일 3깡은 기본','혜림이가 했서','난 모르겠다',
  '네다씹','그게 먼데 씹덕아','ㄴㄷ^^','네녀석.. .진심인게냐..?', '재밌냐?',
  '삐리삐리','바람나써','왼손은 흑염룡이 지배한다','응, 니 손가락',
  '닥쳐','제발 좀...','-꼰-','-찐-',
];

Random random = Random(DateTime.now().millisecondsSinceEpoch);

Map<String, List<ChatDetail>> _cachedChatDetails = {};

class ChatDetail<T> {
  bool current;
  T content;

  ChatDetail(this.content, {this.current: true});

  static List<ChatDetail> getInitChatDetails(String friendName) {
    _cachedChatDetails[friendName] ??= (){
      List<ChatDetail> list = [];
      for(var i = 1; i <= 50; i++) {
        if(random.nextInt(100) < 20) {
          list.add(TimeMessage(DateTime.now()));
        }
        list.add(randomChatDetail(i % 2 == 0));
      }
      return list;
    }();
    return _cachedChatDetails[friendName];
  }

  static ChatDetail randomChatDetail(bool current) {
    int v = random.nextInt(100);
    if (v < 50) {
      return EmojiChatDetail(Emoji(random.nextInt(emojiTotalCount)), current: current);
    }
    return StringChatDetail(_chatDetails[random.nextInt(_chatDetails.length)], current: current);
  }
}

class StringChatDetail extends ChatDetail<String>{
  StringChatDetail(content, {bool current: true,}): super(content, current: current);

}

const emojiTotalCount = 116;
class Emoji {
  int code;
  Emoji(this.code);

  String get file {
    return 'images/chat/emoji/emoji_${code < 10 ? '0' : ''}$code.png';
  }
}


class ImageChatDetail extends ChatDetail<File> {
  ImageChatDetail(File content, {bool current: true,}) : super(content, current: current);
  // static File getRandomImageFile(BuildContext context) {
  // }
}

class EmojiChatDetail extends ChatDetail<Emoji> {
  EmojiChatDetail(Emoji content, {bool current: true,}) : super(content, current: current);
}

class TimeMessage extends ChatDetail<DateTime> {
  TimeMessage(DateTime content) : super(content);
}