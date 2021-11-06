String version;
String passKeyFlutter;

final String gaapServer = 'http://www.gaap.gg:8000/';
final String testServer = 'http://192.168.10.112:8000/';

//수정은 이부분만!!!!!
String currentServer = gaapServer;

class Url {
  String ddragon = 'http://ddragon.leagueoflegends.com/cdn/';
  String version = 'https://ddragon.leagueoflegends.com/api/versions.json';

  String createSummonerName = currentServer + 'createSummonerName/?';

  String champListUrl = currentServer + 'champList/';
  String champInfoListUrl = currentServer + 'champInfoList/';
  String summonerName = currentServer + 'summonerInfo/?summonerName=';
  String summonerMatchHistory =
      currentServer + 'summonerMatchHistory/?summonerName=';
  String gameInfo = currentServer + 'gameInfo/?gameId=';

  String urlKey = currentServer + 'passKey/';
  String gameStrat = currentServer + 'gameStart/?summonerName=';
  String recommendGame = currentServer + 'recommendGame/';

  String boardData = currentServer + 'boardData/';

  String boardDelete = currentServer + 'boardDelete/?id=';
  String boardWrite = currentServer + 'boardWrite';
  String boardUpdate = currentServer + 'boardUpdate';

  String boardCommentSearch = currentServer + 'boardCommentSearch/?id=';
  String boardCommentDelete = currentServer + 'boardCommentDelete/?id=';
  String boardComment = currentServer + 'boardComment';
}

class AuthUrl {
  String createSummonerName = currentServer + 'createSummonerName/';
  String checkSummonerName = currentServer + 'checkSummonerName/';
  String inputSummonerName = currentServer + 'inputSummonerName/';
}

class KeyPlus {
  urlkeyPlus(String text) {
    String keytext = passKeyFlutter;
    text = text + "?key=" + keytext;
    return text;
  }

  urlkeyPlusSub(String text) {
    String keytext = passKeyFlutter;
    text = text + "&key=" + keytext;
    return text;
  }
}
