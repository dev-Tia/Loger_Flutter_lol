import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gaap/Url_List.dart';
import 'package:extended_image/extended_image.dart';

class ChampRune extends StatefulWidget {
  final String champkey;
  ChampRune(this.champkey);
  @override
  createState() => new ChampRuneState();
}

class ChampRuneState extends State<ChampRune>
    with AutomaticKeepAliveClientMixin {
  //함수 for문 용
  var i = 0;
  var j = 0;
  var v = 0;
  int x = 0;
  //받아온 키 버전 저장용
  var champkey = '';
  bool runeState = false;
  //메인 룬 관련 변수
  var mainLA = 1;
  var mainLB = 1;
  var mainLC = 1;
  var mainRC = 1;
  List<String> mainRune = [];
  List<String> mainRI = [];
  List<String> mainRU = [];
  List<String> mainRN = [];
  List<int> mainRL = [];

  //서브 룬 관련 변수
  var subLA = 1;
  var subLB = 1;
  var subLC = 1;
  var subRC = 1;
  List<String> subRune = [];
  List<String> subRI = [];
  List<String> subRU = [];
  List<String> subRN = [];
  List<int> subRL = [];

  @override
  void initState() {
    super.initState();
    champInfoUrl();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (subRL.isNotEmpty) {
      subLA = subRL[0] + 1;
      subLB = subRL[0] + 1;
      subLC = subRL[0] + 1;
    }
    if (mainLA > mainRL.length) {
      mainLA = 1;
      mainLB = 1;
      mainLC = 1;
    }

    print('mainRN = $mainRN.toString()');
    var m = MediaQuery.of(context).size;
    champkey = widget.champkey;
    return Container(
        child: Column(
      children: <Widget>[
        title(m),
        runeState
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[mainRunesAll(m, x), subRunesAll(m)],
              )
            : loading(m)
      ],
    ));
  }

  Widget title(Size m) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '추천 룬',
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: m.height / 40),
        ),
        Container(
          width: m.width * 0.3,
          height: m.height / 400,
          margin: EdgeInsets.fromLTRB(0, m.height / 80, 0, m.height / 80),
          color: Color.fromRGBO(242, 226, 5, 1),
        )
      ],
    ));
  }

//gif이미지 로딩
  Widget loading(Size m) {
    return Container(
      width: m.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: m.width * 5,
              height: m.height / 5,
              child: Image.asset('images/etc/Crab.v1.gif')
              /* LinearProgressIndicator(
                            backgroundColor: Color.fromARGB(242, 242, 242, 1),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(242, 226, 5, 1))) */
              )
        ],
        /*  margin: EdgeInsets.fromLTRB(
                              0, m.height / 50, 0, m.height / 5),
                  child:Text("LOADING...",style: TextStyle(fontWeight: FontWeight.bold , fontSize: m.height/20),) */
      ),
    );
  }

  /*  Widget _buildAboutDialog(BuildContext context) {
    if (mainRN.length == x) {
      x = 0;
    }
    return new AlertDialog(
      backgroundColor: Colors.white,
      title: Text(mainRN[x++]),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text('')],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('확인'),
        ),
      ],
    );
  }
 */
//메인 룬 전체
  Widget mainRunesAll(Size m, int x) {
    const Duration waitDuration = Duration(milliseconds: 0);

    return Container(
      width: m.width / 2.3,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, m.height / 100, 0, m.height / 100),
          child: Tooltip(
              waitDuration: waitDuration,
              message: mainRN[0],
              child: ExtendedImage.network(
                Url().ddragon + 'img/' + mainRU[0],
                fit: BoxFit.fill,
                cache: true,
              )),
        ),
        mainRinesList(m, 0),
        mainRinesList(m, 1),
        mainRinesList(m, 2),
        mainRinesList(m, 3),
      ]),
    );
  }

//메인 룬 한줄
  Widget mainRinesList(Size m, int i) {
    return mainRL[i] == 4
        ? Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, m.height / 800),
            height: m.height / 18,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                ]))
        : Container(
            //color: Colors.white10,
            margin: EdgeInsets.fromLTRB(0, 0, 0, m.height / 800),
            height: m.height / 18,
            width: m.width / 2.15 * 0.75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                  mainRunes(m, i + 1, mainLA++, mainLB++, mainLC++),
                ]));
  }

//메인 룬 각 요소
  Widget mainRunes(Size m, int i, int mainLA, int mainLB, int mainLC) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Tooltip(
              waitDuration: Duration(milliseconds: 100),
              message: mainRN[mainLA],
              child: Stack(
                children: <Widget>[
                  mainRune[i] != mainRI[mainLC]
                      ? CachedNetworkImage(
                          imageUrl: Url().ddragon + 'img/' + mainRU[mainLB],
                          width: m.width / 15,
                          height: m.width / 15,
                          //fit: BoxFit.fill,
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          colorBlendMode: BlendMode.modulate,
                        )
                      : CachedNetworkImage(
                          imageUrl: Url().ddragon + 'img/' + mainRU[mainLB],
                          width: m.width / 15,
                          height: m.width / 15,
                          fit: BoxFit.fill,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//서브 룬 전체
  Widget subRunesAll(Size m) {
    return Container(
      width: m.width / 2.3,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        //----------------------------subRI----------------------------------//
        Container(
            margin: EdgeInsets.fromLTRB(0, m.height / 50, 0, m.height / 50),
            child: Tooltip(
                message: subRN[0],
                child: ExtendedImage.network(
                  Url().ddragon + 'img/' + subRU[0],
                  fit: BoxFit.fill,
                  width: m.width / 12,
                  cache: true,
                  /* border: Border.all(color: Colors.red, width: 1.0),
              shape: BoxShape.circle,
              borderRadius: BorderRadius.all(Radius.circular(30.0)), */
                ))),
        subRunesList(m, 1),
        subRunesList(m, 2),
        subRunesList(m, 3),
        Container(
          height: m.height / 15,
        ),
      ]),
    );
  }

//서브 룬 한줄
  Widget subRunesList(Size m, int i) {
    return subRL[i] == 4
        ? Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, m.height / 800),
            height: m.height / 18,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  subRunes(m, subLA++, subLB++, subLC++),
                  subRunes(m, subLA++, subLB++, subLC++),
                  subRunes(m, subLA++, subLB++, subLC++),
                  subRunes(m, subLA++, subLB++, subLC++),
                ]))
        : Container(
            //color: Colors.white10,
            margin: EdgeInsets.fromLTRB(0, 0, 0, m.height / 800),
            height: m.height / 18,
            width: m.width / 2.15 * 0.75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  subRunes(m, subLA++, subLB++, subLC++),
                  subRunes(m, subLA++, subLB++, subLC++),
                  subRunes(m, subLA++, subLB++, subLC++),
                ]));
  }

//서브 룬 각 요소
  Widget subRunes(Size m, int subLA, int subLB, int subLC) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Tooltip(
          message: subRN[subLA++],
          child: Stack(
            children: <Widget>[
              !subRune[2].contains(subRI[subLC++]) &&
                      !subRune[3].contains(subRI[subLC - 1]) &&
                      !subRune[1].contains(subRI[subLC - 1])
                  ? CachedNetworkImage(
                      alignment: Alignment.center,
                      imageUrl: Url().ddragon + 'img/' + subRU[subLB++],
                      width: m.width / 15,
                      fit: BoxFit.fill,
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      colorBlendMode: BlendMode.modulate,
                    )
                  : CachedNetworkImage(
                      alignment: Alignment.center,
                      imageUrl: Url().ddragon + 'img/' + subRU[subLB++],
                      width: m.width / 15,
                      fit: BoxFit.fill,
                      colorBlendMode: BlendMode.softLight,
                    )
            ],
          ),
        ),
      ),
    );
  }

//챔피언 정보 JSON log-eye
  void champInfoUrl() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
      () async {
        http.Response response;
        String body;
        try {
          response =
              await http.get(KeyPlus().urlkeyPlus(Url().champInfoListUrl));
          body = utf8.decode(response.bodyBytes);
          if (response.statusCode == 200) {
            var jsonData = json.decode(body);
            mainRune = List<String>(
                jsonData[widget.champkey]['runes'][0]['main'].length);
            subRune = List<String>(
                jsonData[widget.champkey]['runes'][0]['sub'].length);
            for (var i = 0;
                i < jsonData[widget.champkey]['runes'][0]['main'].length;
                i++) {
              mainRune[i] =
                  (jsonData[widget.champkey]['runes'][0]['main'][i].toString());
            }
            for (var i = 0;
                i < jsonData[widget.champkey]['runes'][0]['sub'].length;
                i++) {
              subRune[i] =
                  (jsonData[widget.champkey]['runes'][0]['sub'][i].toString());
            }
            if (mainRune[0].isNotEmpty) {
              runesInfo();
            }
            //setState(() {});
          } else {
            print('champInfoUrl Fail');
            champInfoUrl();
          }
        } catch (e) {
          print('champInfoUrl Fail = $e');
          champInfoUrl();
        }
      },
    );
  }

//룬 정보 ddragon
  void runesInfo() async {
    await Future.delayed(const Duration(milliseconds: 200), () async {
      final response = await http
          .get(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
      String body = utf8.decode(response.bodyBytes);

      var jsonData = json.decode(body);
      if (mounted)
        for (i = 0; i < jsonData.length; i++) {
          if (jsonData[i]['id'].toString() == mainRune[0]) {
            mainRI = List<String>(jsonData[i]['slots'][0]['runes'].length +
                jsonData[i]['slots'][1]['runes'].length +
                jsonData[i]['slots'][2]['runes'].length +
                jsonData[i]['slots'][3]['runes'].length +
                1);
            mainRN = List<String>(jsonData[i]['slots'][0]['runes'].length +
                jsonData[i]['slots'][1]['runes'].length +
                jsonData[i]['slots'][2]['runes'].length +
                jsonData[i]['slots'][3]['runes'].length +
                1);
            mainRI[0] = jsonData[i]['id'].toString();
            mainRU = List<String>(jsonData[i]['slots'][0]['runes'].length +
                jsonData[i]['slots'][1]['runes'].length +
                jsonData[i]['slots'][2]['runes'].length +
                jsonData[i]['slots'][3]['runes'].length +
                1);
            mainRU[0] = jsonData[i]['icon'];
            mainRN[0] = jsonData[i]['name'].toString();

            mainRL = List<int>(jsonData[i]['slots'].length);
            for (v = 0; v < jsonData[i]['slots'].length; v++) {
              for (j = 1; j <= jsonData[i]['slots'][v]['runes'].length; j++) {
                mainRI[mainRC] =
                    jsonData[i]['slots'][v]['runes'][j - 1]['id'].toString();
                mainRU[mainRC] =
                    jsonData[i]['slots'][v]['runes'][j - 1]['icon'];
                mainRN[mainRC] =
                    jsonData[i]['slots'][v]['runes'][j - 1]['name'].toString();
                mainRC++;
              }
              mainRL[v] = jsonData[i]['slots'][v]['runes'].length;
            }
          } else if (jsonData[i]['id'].toString() == subRune[0]) {
            subRI = List<String>(jsonData[i]['slots'][0]['runes'].length +
                jsonData[i]['slots'][1]['runes'].length +
                jsonData[i]['slots'][2]['runes'].length +
                jsonData[i]['slots'][3]['runes'].length +
                1);
            subRN = List<String>(jsonData[i]['slots'][0]['runes'].length +
                jsonData[i]['slots'][1]['runes'].length +
                jsonData[i]['slots'][2]['runes'].length +
                jsonData[i]['slots'][3]['runes'].length +
                1);
            subRI[0] = jsonData[i]['id'].toString();
            subRN[0] = jsonData[i]['name'].toString();
            subRU = List<String>(jsonData[i]['slots'][0]['runes'].length +
                jsonData[i]['slots'][1]['runes'].length +
                jsonData[i]['slots'][2]['runes'].length +
                jsonData[i]['slots'][3]['runes'].length +
                1);
            subRU[0] = jsonData[i]['icon'];

            subRL = List<int>(jsonData[i]['slots'].length);
            for (v = 0; v < jsonData[i]['slots'].length; v++) {
              for (j = 1; j <= jsonData[i]['slots'][v]['runes'].length; j++) {
                subRI[subRC] =
                    jsonData[i]['slots'][v]['runes'][j - 1]['id'].toString();
                subRU[subRC] = jsonData[i]['slots'][v]['runes'][j - 1]['icon'];
                subRN[subRC] = jsonData[i]['slots'][v]['runes'][j - 1]['name'];
                subRC++;
              }
              subRL[v] = jsonData[i]['slots'][v]['runes'].length;
            }
          }
        }
      setState(() {
        runeState = true;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
