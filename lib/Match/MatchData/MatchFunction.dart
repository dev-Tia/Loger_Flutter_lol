import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:gaap/Providers/MatchProvider.dart';
import 'package:gaap/Url_List.dart';

//blue 팀 정보
//소환사 이름
List<String> summonerNameA = List<String>(5);
//소환사 티어
List<String> tierA = List<String>(5);
//챔피언 영어 이름
List<String> championA = List<String>(5);
//ddragon 내의 챔피언 이미지 링크
List<String> championLinkA = List<String>(5);
//챔피언 레벨
List<String> champLevelA = List<String>(5);
//첫번째 스펠
List<String> spellAA = List<String>(5);
//두번째 스펠
List<String> spellBA = List<String>(5);
//첫번째 룬
List<String> runesAA = List<String>(5);
//두번째 룬
List<String> runesBA = List<String>(5);
//킬
List<int> killsA = List<int>(5);
//데스
List<int> deathsA = List<int>(5);
//어시스트
List<int> assistsA = List<int>(5);
//아이템
List<List> itemA = List<List>(5);
//악세
List<String> accsA = List<String>(5);
//획득 CS
List<String> totalCsA = List<String>(5);
//분당 CS
List<String> csA = List<String>(5);

//red 팀 정보
//소환사 이름
List<String> summonerNameB = List<String>(5);
//소환사 티어
List<String> tierB = List<String>(5);
//챔피언 영어 이름
List<String> championB = List<String>(5);
//ddragon 내의 챔피언 이미지 링크
List<String> championLinkB = List<String>(5);
//챔피언 레벨
List<String> champLevelB = List<String>(5);
//첫번째 스펠
List<String> spellAB = List<String>(5);
//두번째 스펠
List<String> spellBB = List<String>(5);
//첫번째 룬
List<String> runesAB = List<String>(5);
//두번째 룬
List<String> runesBB = List<String>(5);
//킬
List<int> killsB = List<int>(5);
//데스
List<int> deathsB = List<int>(5);
//어시스트
List<int> assistsB = List<int>(5);
//아이템
List<List> itemB = List<List>(5);
//악세
List<String> accsB = List<String>(5);
//획득 CS
List<String> totalCsB = List<String>(5);
//분당 CS
List<String> csB = List<String>(5);

//통합한 정보
//소환사 이름
List<String> summonName = List<String>(10);
//소환사 티어
List<String> tier = List<String>(10);
//챔피언 영어 이름
List<String> champion = List<String>(10);
//ddragon 내의 챔피언 이미지 링크
List<String> championLink = List<String>(10);
//챔피언 레벨
List<String> champLevel = List<String>(10);
//첫번째 스펠
List<String> spellA = List<String>(10);
//두번째 스펠
List<String> spellB = List<String>(10);
//첫번째 룬
List<String> runesA = List<String>(10);
//두번째 룬
List<String> runesB = List<String>(10);
//ddragon 에서 첫번째 룬에 대한 링크
List<String> runesALink = List<String>(10);
//ddragon 에서 첫번째 룬에 대한 링크
List<String> runesBLink = List<String>(10);
//킬
List<int> kills = List<int>(10);
//데스
List<int> deaths = List<int>(10);
//어시스트
List<int> assists = List<int>(10);
//아이템
List<List> item = List<List>(10);
//악세
List<String> accs = List<String>(10);
//획득 CS
List<String> totalCs = List<String>(10);
//분당 CS
List<String> cs = List<String>(10);
//KDA 점수 계산
List<String> kda = List<String>(10);
//승리한 팀 blue인지 red인지
String winTeam;
//blue 킬 총합
int killsTotalA;
//red 킬 총합
int killsTotalB;
//blue 골드 총합
int goldEarnedA;
//red 골드 총합
int goldEarnedB;

double killsTotal;

double goldEarned;

bool callgameInfoState = false;
bool nameState = false;
bool runesInfoState = false;

//미디어 쿼리를 사용하기 위한 함수
class Size {
  static MediaQueryData _mediaQueryData;
  static double width;
  static double height;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
  }
}

class MatchCall {
  //사용했던 상태 정보 초기화
  Future<void> reset() async {
    callgameInfoState = false;
    nameState = false;
    runesInfoState = false;
  }

  //100 = blue 200= red
  Future<void> callgameInfo(context, int gameid, String summonerName) async {
    final providerMatch = Provider.of<MatchProvider>(context, listen: false);
    print('callgameInfo()Start');
    String url = Url().gameInfo + gameid.toString();
    try {
      http.Response response = await http.get(KeyPlus().urlkeyPlusSub(url));
      print(KeyPlus().urlkeyPlusSub(url));
      String body = utf8.decode(response.bodyBytes);
      var jsonData = jsonDecode(body);
      if (response.statusCode == 200) {
        killsTotalA = jsonData['team100Total']['kills'];

        killsTotalB = jsonData['team200Total']['kills'];

        killsTotal = killsTotalA / (killsTotalA + killsTotalB);
        goldEarnedA = jsonData['team100Total']['goldEarned'];

        goldEarnedB = jsonData['team200Total']['goldEarned'];

        goldEarned = goldEarnedA / (goldEarnedA + goldEarnedB);

        for (int i = 0; i < 5; i++) {
          //승리한 팀
          winTeam = jsonData['winTeam'].toString();

          //blueTeam
          summonerNameA[i] = jsonData["match"]["100"][i]["summonerName"];

          tierA[i] = jsonData["match"]["100"][i]["tier"];

          championA[i] = jsonData["match"]["100"][i]["champion"];

          championLinkA[i] =
              '${Url().ddragon}$version/img/champion/${championA[i]}.png';
          providerMatch.inputgameUrl(i, championLinkA[i]);

          champLevelA[i] = jsonData["match"]["100"][i]["champLevel"].toString();

          spellAA[i] = jsonData["match"]["100"][i]["spellA"];
          spellAA[i] = '${Url().ddragon}$version/img/spell/${spellAA[i]}.png';

          spellBA[i] = jsonData["match"]["100"][i]["spellB"];
          spellBA[i] = '${Url().ddragon}$version/img/spell/${spellBA[i]}.png';

          runesAA[i] = jsonData["match"]["100"][i]["runeA"].toString();
          runesBA[i] = jsonData["match"]["100"][i]["runeB"].toString();

          killsA[i] = jsonData["match"]["100"][i]["kills"];

          deathsA[i] = jsonData["match"]["100"][i]["deaths"];

          assistsA[i] = jsonData["match"]["100"][i]["assists"];

          itemA[i] = jsonData["match"]["100"][i]["item"];

          accsA[i] = jsonData["match"]["100"][i]["accs"].toString();

          totalCsA[i] = jsonData["match"]["100"][i]["totalCS"].toString();

          csA[i] = jsonData["match"]["100"][i]["cs"].toString();

          //redTeam
          summonerNameB[i] = jsonData["match"]["200"][i]["summonerName"];

          tierB[i] = jsonData["match"]["200"][i]["tier"];

          championB[i] = jsonData["match"]["200"][i]["champion"];

          championLinkB[i] =
              '${Url().ddragon}$version/img/champion/${championB[i]}.png';
          providerMatch.inputgameUrl(i + 5, championLinkB[i]);
          champLevelB[i] = jsonData["match"]["200"][i]["champLevel"].toString();

          spellAB[i] = jsonData["match"]["200"][i]["spellA"];
          spellAB[i] = '${Url().ddragon}$version/img/spell/${spellAB[i]}.png';

          spellBB[i] = jsonData["match"]["200"][i]["spellB"];
          spellBB[i] = '${Url().ddragon}$version/img/spell/${spellBB[i]}.png';

          runesAB[i] = jsonData["match"]["200"][i]["runeA"].toString();
          runesBB[i] = jsonData["match"]["200"][i]["runeB"].toString();

          killsB[i] = jsonData["match"]["200"][i]["kills"];

          deathsB[i] = jsonData["match"]["200"][i]["deaths"];

          assistsB[i] = jsonData["match"]["200"][i]["assists"];

          itemB[i] = jsonData["match"]["200"][i]["item"];

          accsB[i] = jsonData["match"]["200"][i]["accs"].toString();

          totalCsB[i] = jsonData["match"]["200"][i]["totalCS"].toString();

          csB[i] = jsonData["match"]["200"][i]["cs"].toString();

          //total
          summonName[i] = summonerNameA[i];
          summonName[i + 5] = summonerNameB[i];

          tier[i] = tierA[i];
          tier[i + 5] = tierB[i];

          champion[i] = championA[i];
          champion[i + 5] = championB[i];

          champLevel[i] = champLevelA[i];
          champLevel[i + 5] = champLevelB[i];

          championLink[i] = championLinkA[i];
          championLink[i + 5] = championLinkB[i];

          spellA[i] = spellAA[i];
          spellA[i + 5] = spellAB[i];

          spellB[i] = spellBA[i];
          spellB[i + 5] = spellBB[i];

          runesA[i] = runesAA[i];
          runesA[i + 5] = runesAB[i];

          runesB[i] = runesBA[i];
          runesB[i + 5] = runesBB[i];

          kills[i] = killsA[i];
          kills[i + 5] = killsB[i];

          deaths[i] = deathsA[i];
          deaths[i + 5] = deathsB[i];

          assists[i] = assistsA[i];
          assists[i + 5] = assistsB[i];

          item[i] = itemA[i];
          item[i + 5] = itemB[i];

          accs[i] = accsA[i];
          accs[i + 5] = accsB[i];
          if (accs[i] == '0') {
            accs[i] = '0';
            accs[i + 5] =
                Url().ddragon + version + '/img/item/${accs[i + 5]}.png';
          } else {
            accs[i] = Url().ddragon + version + '/img/item/${accs[i]}.png';
            accs[i + 5] =
                Url().ddragon + version + '/img/item/${accs[i + 5]}.png';
          }

          totalCs[i] = totalCsA[i];
          totalCs[i + 5] = totalCsB[i];

          cs[i] = csA[i];
          cs[i + 5] = csB[i];

          //item Url 만들기
          for (int j = 0; j < 6; j++) {
            if (item[i][j] == 0) {
              item[i][j] = '0';
            } else {
              item[i][j] =
                  '${Url().ddragon}$version/img/item/${item[i][j]}.png';
            }
            providerMatch.inputItem(i, item[i]);
          }

          for (int j = 0; j < 6; j++) {
            if (item[i + 5][j] == 0) {
              item[i + 5][j] = '0';
            } else {
              item[i + 5][j] = '${Url().ddragon}$version/img/item/' +
                  item[i + 5][j].toString() +
                  '.png';
            }
            providerMatch.inputItem(i + 5, item[i + 5]);
          }

          //KDA 계산하기
          if (deaths[i] == 0) {
            deaths[i] = 1;
            kda[i] = (((kills[i] + assists[i]) / deaths[i]) * 1.2)
                    .toStringAsFixed(1) +
                ':1';
          } else if (kills[i] + assists[i] == 0) {
            kda[i] = '0:1';
          } else {
            kda[i] =
                ((kills[i] + assists[i]) / deaths[i]).toStringAsFixed(1) + ':1';
          }
          if (deaths[i + 5] == 0) {
            deaths[i + 5] = 1;
            kda[i + 5] =
                (((kills[i + 5] + assists[i + 5]) / deaths[i + 5]) * 1.2)
                        .toStringAsFixed(1) +
                    ':1';
          } else if (kills[i + 5] + assists[i + 5] == 0) {
            kda[i + 5] = '0:1';
          } else {
            kda[i + 5] = ((kills[i + 5] + assists[i + 5]) / deaths[i + 5])
                    .toStringAsFixed(1) +
                ':1';
          }
        }
        for (int i = 0; i < 10; i++) {
          if (tier[i].contains('Unranked')) {
            tier[i] = 'Un';
          } else if (tier[i].contains('IRON')) {
            tier[i] = tier[i].replaceAll('IRON', 'I');
          } else if (tier[i].contains('BRONZE')) {
            tier[i] = tier[i].replaceAll('BRONZE', 'B');
          } else if (tier[i].contains('SILVER')) {
            tier[i] = tier[i].replaceAll('SILVER', 'S');
          } else if (tier[i].contains('GOLD')) {
            tier[i] = tier[i].replaceAll('GOLD', 'G');
          } else if (tier[i].contains('PLATINUM')) {
            tier[i] = tier[i].replaceAll('PLATINUM', 'P');
          } else if (tier[i].contains('DIAMOND')) {
            tier[i] = tier[i].replaceAll('DIAMOND', 'D');
          } else if (tier[i].contains('MASTER')) {
            tier[i] = tier[i].replaceAll('MASTER', 'M');
          } else if (tier[i].contains('GRANDMASTER')) {
            tier[i] = tier[i].replaceAll('GRANDMASTER', 'GM');
          } else if (tier[i].contains('CHALLENGER')) {
            tier[i] = tier[i].replaceAll('CHALLENGER', 'C');
          }
        }

        callgameInfoState = true;
        //blue팀에 기준이 되는 소환사 이름이 있는지 판단
        if (summonerNameA.contains(summonerName)) {
          nameState = true;
        }
        //callgameInfo() 에서 얻은 룬 정보를 값으로 전달
        runesInfo(context);
      }
    } catch (e) {
      print('callgameInfo() Error $e');
      Future.delayed(const Duration(seconds: 3), () async {
        callgameInfo(context, gameid, summonerName);
      });
    }
  }

  runesInfo(context) async {
    final providerMatch = Provider.of<MatchProvider>(context, listen: false);
    String url = Url().ddragon + version + '/data/ko_KR/runesReforged.json';
    try {
      final response = await http.get(url);
      print(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
      String body = utf8.decode(response.bodyBytes);

      var jsonData = json.decode(body);
      //첫번째 룬을 가져옴
      //runA의 길이만큼 반복
      for (var i = 0; i < 10; i++) {
        //룬의 최상위 요소(정밀 감전등)만큼 반복
        for (var j = 0; j < jsonData.length; j++) {
          //첫번째 룬의 길이 만큼 반복
          for (var k = 0; k < jsonData[j]['slots'][0]['runes'].length; k++) {
            // runesA[i]가 첫번째 룬에 포함되어 있는지 확인
            if (runesA[i] ==
                jsonData[j]['slots'][0]['runes'][k]['id'].toString()) {
              // 있을 시 그 룬의 웹 이미지 링크를 runesALink에 저장
              runesALink[i] =
                  '${Url().ddragon}img/${jsonData[j]['slots'][0]['runes'][k]['icon']}';
              providerMatch.inputspellA(i, runesALink[i]);
            }
          }
        }
      }
      //첫번째 룬을 가져옴
      //runㅠ의 길이만큼 반복
      for (var i = 0; i < 10; i++) {
        //룬의 최상위 요소(정밀 감전등)만큼 반복
        for (var j = 0; j < jsonData.length; j++) {
          // runesB[i]가 어떤 룬인지 확인
          if (runesB[i] == jsonData[j]['id'].toString()) {
            // runesB[i]와 일치하는 웹 이미지 링크를 runesBLink에 저장
            runesBLink[i] = '${Url().ddragon}img/${jsonData[j]['icon']}';
            providerMatch.inputspellB(i, runesBLink[i]);
          }
        }
      }
      runesInfoState = true;
      //itemInfo(context);
    } catch (e) {
      print('runesInfo() Error $e');
      Future.delayed(const Duration(seconds: 3), () async {
        runesInfo(context);
      });
    }
  }

  /*  
    item 세부정보가 필요할시 사용
    itemInfo(context) async {
    print('itemInfo() Start');
    final providerMatch = Provider.of<MatchProvider>(context, listen: false);
    String url = Url().ddragon + version + '/data/ko_KR/item.json';
    print(url);
    try {
      final response = await http.get(url);
      print(url);
      String body = utf8.decode(response.bodyBytes);

      var jsonData = json.decode(body);
    } catch (e) {
      print('itemInfo() Error = $e');
      Future.delayed(const Duration(seconds: 3), () async {
        itemInfo(context);
      });
    }
  } */
}
