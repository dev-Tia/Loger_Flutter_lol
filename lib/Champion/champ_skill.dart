import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gaap/Url_List.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'subStringFunction.dart';

class ChampSkill extends StatefulWidget {
  final String champkey;
  ChampSkill(this.champkey);
  @override
  createState() => new ChampSkillState();
}

class ChampSkillState extends State<ChampSkill>
    with AutomaticKeepAliveClientMixin {
  final subString = SubString();
  // for문용 변수
  var i = 0;
  // 챔피언 이름
  var champName = '';

  //스킬 관련 변수
  var skillAId = '';
  var skillAName = '';
  var skillAInfo = '';
  var skillBId = '';
  var skillBName = '';
  var skillBInfo = '';
  var skillCId = '';
  var skillCName = '';
  var skillCInfo = '';
  var skillPicRate = '';
  var skillWinRate = '';
  var start = '<';
  var end = '>';
  var subStringText = '';
  var startIndex = 0;
  var endIndex = 0;
  String result = '';
  List<String> skillA = [];

  //아이템 관련 변수

  List<String> recommenditemA = [];
  List<String> recommenditemAName = [];
  List<String> recommenditemADescription = [];
  List<String> recommenditemAGoldBase = [];
  List<String> recommenditemAGoldTotal = [];

  List<String> recommenditemB = [];
  List<String> recommenditemBName = [];
  List<String> recommenditemBDescription = [];
  List<String> recommenditemBGoldBase = [];
  List<String> recommenditemBGoldTotal = [];

  List<String> recommendShoes = [];
  List<String> recommendShoesName = [];
  List<String> recommendShoesDescription = [];
  List<String> recommendShoesGoldBase = [];
  List<String> recommendShoesGoldTotal = [];

  int startitemALength = 0;
  String startitemAPic = '';
  String startitemAWin = '';

  List<String> startitemA = [];
  List<String> startitemAName = [];
  List<String> startitemADescription = [];
  List<String> startitemAGoldBase = [];
  List<String> startitemAGoldTotal = [];

  int startitemBLength = 0;
  String startitemBPic = '';
  String startitemBWin = '';

  List<String> startitemB = [];
  List<String> startitemBName = [];
  List<String> startitemBDescription = [];
  List<String> startitemBGoldBase = [];
  List<String> startitemBGoldTotal = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    champInfoUrl();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var m = MediaQuery.of(context).size;
    return recommenditemADescription.isNotEmpty
        ? Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Card(
                  shape: ContinuousRectangleBorder(
                    side: BorderSide(color: Colors.yellow[600], width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Color.fromRGBO(2, 6, 89, 1),
                  elevation: 5,
                  color: Colors.white,
                  margin: EdgeInsets.all(15),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Column(
                      children: <Widget>[
                        title(m, '추천 스킬 빌드'),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        skillList(m),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: ContinuousRectangleBorder(
                    side: BorderSide(color: Colors.yellow[600], width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Color.fromRGBO(2, 6, 89, 1),
                  elevation: 5,
                  color: Colors.white,
                  margin: EdgeInsets.all(15),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Column(
                      children: <Widget>[
                        title(m, '추천 시작 아이템 빌드'),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        startitemAList(m),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        startitemBList(m),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        title(m, '추천 최종 아이템 빌드'),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        recommenditemAList(m),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        recommenditemBList(m),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        title(m, '추천 신발'),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                        recommendShoesList(m),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0, m.height / 80, 0, m.height / 80),
                        ),
                      ],
                    ),
                  ),
                ),

                /* Text(widget.champkey),
            Text(widget.version),
            Text(skillA.toString()),
            Text(skillAName + skillBName + skillCName),
            Text(recommenditemA.toString()),
            Text(recommenditemAName.toString()),
            Text(recommenditemADescription.toString()),
            Text(recommenditemAGoldBase.toString()),
            Text(recommenditemAGoldTotal.toString()) */
              ]
                //제목
                ))
        : Container(
            width: m.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: m.width * 5,
                    height: m.height / 5,
                    child: Image.asset('images/etc/Crab.v1.gif'))
              ],
            ),
          );
  }

  Widget title(Size m, String title) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: m.height / 40),
        ),
        Container(
          width: m.width * 0.6,
          height: m.height / 400,
          margin: EdgeInsets.fromLTRB(0, m.height / 80, 0, m.height / 80),
          color: Color.fromRGBO(242, 226, 5, 1),
        )
      ],
    ));
  }

  Widget skillinfo(int i, Size m) {
    return Tooltip(
        message: i == 0 ? skillAInfo : i == 1 ? skillBInfo : skillCInfo,
        margin: EdgeInsets.fromLTRB(m.height / 30, 0, m.height / 30, 0),
        textStyle: TextStyle(color: Color.fromRGBO(2, 6, 89, 1)),
        decoration: BoxDecoration(color: Color.fromRGBO(242, 226, 5, 1)),
        child: Stack(
          children: <Widget>[
            Container(
                color: Colors.black,
                width: m.width / 10,
                padding: EdgeInsets.all(2.0),
                child: InkWell(
                    child: CachedNetworkImage(
                  imageUrl: Url().ddragon +
                      version +
                      '/img/spell/' +
                      skillA[i] +
                      '.png',
                  errorWidget: (context, url, error) => Icon(Icons.image),
                  width: m.width / 5,
                  fit: BoxFit.fill,
                ))),
            Container(
              //color: Colors.black45,
              child: Text(
                i == 0 ? skillAName : i == 1 ? skillBName : skillCName,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ],
        ));
  }

  Widget skillList(Size m) {
    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 30, 0, m.width / 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            skillinfo(0, m),
            Container(
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            skillinfo(1, m),
            Container(
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            skillinfo(2, m),
          ]),
          Column(
            children: <Widget>[
              Container(
                child: Text('픽률 : ' + skillPicRate,
                    style: TextStyle(fontSize: m.width / 30)),
              ),
              Container(
                child: Text('승률 : ' + skillWinRate,
                    style: TextStyle(fontSize: m.width / 30)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget startitemAinfo(Size m, int i) {
    return startitemALength > i
        ? Tooltip(
            message: startitemAName[i] +
                '\n' +
                startitemADescription[i] +
                '\n\n가격 :' +
                startitemAGoldTotal[i],
            /* margin:
            EdgeInsets.fromLTRB(m.height / 10, m.height / 30, m.height / 10, 0), */
            verticalOffset: m.width / 40,
            height: 24,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            preferBelow: true,
            textStyle: TextStyle(
                color: Color.fromRGBO(2, 6, 89, 1), fontSize: m.height / 60),
            decoration:
                BoxDecoration(color: Color.fromRGBO(242, 242, 242, 0.9)),
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(2.0),
                    color: Colors.black,
                    width: m.width / 10,
                    child: InkWell(
                        child: CachedNetworkImage(
                      imageUrl: Url().ddragon +
                          version +
                          '/img/item/' +
                          startitemA[i] +
                          '.png',
                      errorWidget: (context, url, error) => Icon(Icons.image),
                      fit: BoxFit.fill,
                    ))),
                Container(
                  //color: Colors.black45,
                  child: Text(
                    '',
                    //recommenditemAName[i],
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ],
            ))
        : Container();
  }

  Widget startitemAList(Size m) {
    print('startitemALength' + startitemALength.toString());
    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 30, 0, m.width / 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              child: startitemAinfo(m, 0),
            ),
            Container(
              child: startitemAinfo(m, 1),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemAinfo(m, 2),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemAinfo(m, 3),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemAinfo(m, 4),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemAinfo(m, 5),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
          ]),
          startitemAWP(m)
        ],
      ),
    );
  }

  Widget startitemAWP(Size m) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('픽률 : ' + startitemAPic,
              style: TextStyle(fontSize: m.width / 30)),
        ),
        Container(
          child: Text('승률 : ' + startitemAWin,
              style: TextStyle(fontSize: m.width / 30)),
        ),
      ],
    );
  }

  Widget startitemBinfo(Size m, int i) {
    return startitemBLength > i
        ? Tooltip(
            message: startitemBName[i] +
                '\n' +
                startitemBDescription[i] +
                '\n\n가격 :' +
                startitemBGoldTotal[i],
            /* margin:
            EdgeInsets.fromLTRB(m.height / 10, m.height / 30, m.height / 10, 0), */
            verticalOffset: m.width / 40,
            height: 24,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            preferBelow: true,
            textStyle: TextStyle(
                color: Color.fromRGBO(2, 6, 89, 1), fontSize: m.height / 60),
            decoration:
                BoxDecoration(color: Color.fromRGBO(242, 242, 242, 0.9)),
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(2.0),
                    color: Colors.black,
                    width: m.width / 10,
                    child: InkWell(
                        child: CachedNetworkImage(
                      imageUrl: Url().ddragon +
                          version +
                          '/img/item/' +
                          startitemB[i] +
                          '.png',
                      errorWidget: (context, url, error) => Icon(Icons.image),
                      fit: BoxFit.fill,
                    ))),
                Container(
                  //color: Colors.black45,
                  child: Text(
                    '',
                    //recommenditemAName[i],
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ],
            ))
        : Container();
  }

  Widget startitemBList(Size m) {
    print(' startitemBLength' + startitemBLength.toString());
    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 30, 0, m.width / 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              child: startitemBinfo(m, 0),
            ),
            Container(
              child: startitemBinfo(m, 1),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemBinfo(m, 2),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemBinfo(m, 3),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemBinfo(m, 4),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
            Container(
              child: startitemBinfo(m, 5),
              margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
            ),
          ]),
          startitemBWP(m)
        ],
      ),
    );
  }

  Widget startitemBWP(Size m) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('픽률 : ' + startitemBPic,
              style: TextStyle(fontSize: m.width / 30)),
        ),
        Container(
          child: Text('승률 : ' + startitemBWin,
              style: TextStyle(fontSize: m.width / 30)),
        ),
      ],
    );
  }

  Widget recommenditemAinfo(Size m, int i) {
    return Tooltip(
        message: recommenditemAName[i] +
            '\n' +
            recommenditemADescription[i] +
            '\n\n가격 :' +
            recommenditemAGoldTotal[i],
        /* margin:
            EdgeInsets.fromLTRB(m.height / 10, m.height / 30, m.height / 10, 0), */
        verticalOffset: m.width / 40,
        height: 24,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        preferBelow: true,
        textStyle: TextStyle(
            color: Color.fromRGBO(2, 6, 89, 1), fontSize: m.height / 60),
        decoration: BoxDecoration(color: Color.fromRGBO(242, 242, 242, 0.9)),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(2.0),
                color: Colors.black,
                width: m.width / 10,
                child: InkWell(
                    child: CachedNetworkImage(
                  imageUrl: Url().ddragon +
                      version +
                      '/img/item/' +
                      recommenditemA[i] +
                      '.png',
                  errorWidget: (context, url, error) => Icon(Icons.image),
                  fit: BoxFit.fill,
                ))),
            Container(
              //color: Colors.black45,
              child: Text(
                '',
                //recommenditemAName[i],
                style: TextStyle(color: Color.fromRGBO(242, 226, 5, 1)),
              ),
            ),
          ],
        ));
  }

  Widget recommenditemAList(Size m) {
    return Container(
        margin: EdgeInsets.fromLTRB(m.width / 30, 0, m.width / 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: recommenditemAinfo(m, 0),
                ),
                Container(
                  child: recommenditemAinfo(m, 1),
                  margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
                ),
                Container(
                  child: recommenditemAinfo(m, 2),
                  margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text('픽률 : ' + recommenditemA[3],
                      style: TextStyle(fontSize: m.width / 30)),
                ),
                Container(
                  child: Text('승률 : ' + recommenditemA[4],
                      style: TextStyle(fontSize: m.width / 30)),
                ),
              ],
            )
          ],
        ));
  }

  Widget recommenditemBinfo(Size m, int i) {
    return Tooltip(
        message: recommenditemBName[i] +
            '\n' +
            recommenditemBDescription[i] +
            '\n\n가격 :' +
            recommenditemBGoldTotal[i],
        /* margin:
            EdgeInsets.fromLTRB(m.height / 10, m.height / 30, m.height / 10, 0), */
        verticalOffset: m.width / 40,
        height: 24,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        preferBelow: true,
        textStyle: TextStyle(
            color: Color.fromRGBO(2, 6, 89, 1), fontSize: m.height / 60),
        decoration: BoxDecoration(color: Color.fromRGBO(242, 242, 242, 0.9)),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(2.0),
                color: Colors.black,
                width: m.width / 10,
                child: InkWell(
                    child: CachedNetworkImage(
                  imageUrl: Url().ddragon +
                      version +
                      '/img/item/' +
                      recommenditemB[i] +
                      '.png',
                  errorWidget: (context, url, error) => Icon(Icons.image),
                  fit: BoxFit.fill,
                ))),
            Container(
              //color: Colors.black45,
              child: Text(
                '',
                //recommenditemAName[i],
                style: TextStyle(color: Color.fromRGBO(242, 226, 5, 1)),
              ),
            ),
          ],
        ));
  }

  Widget recommenditemBList(Size m) {
    return Container(
        margin: EdgeInsets.fromLTRB(m.width / 30, 0, m.width / 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: recommenditemBinfo(m, 0),
                ),
                Container(
                  child: recommenditemBinfo(m, 1),
                  margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
                ),
                Container(
                  child: recommenditemBinfo(m, 2),
                  margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text('픽률 : ' + recommenditemB[3],
                      style: TextStyle(fontSize: m.width / 30)),
                ),
                Container(
                  child: Text('승률 : ' + recommenditemB[4],
                      style: TextStyle(fontSize: m.width / 30)),
                ),
              ],
            )
          ],
        ));
  }

  Widget recommendShoesinfo(Size m, int i) {
    return Tooltip(
        message: recommendShoesName[i] +
            '\n' +
            recommendShoesDescription[i] +
            '\n\n가격 :' +
            recommendShoesGoldTotal[i],
        /* margin:
            EdgeInsets.fromLTRB(m.height / 10, m.height / 30, m.height / 10, 0), */
        verticalOffset: m.width / 40,
        height: 24,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        preferBelow: true,
        textStyle: TextStyle(
            color: Color.fromRGBO(2, 6, 89, 1), fontSize: m.height / 60),
        decoration: BoxDecoration(color: Color.fromRGBO(242, 242, 242, 0.9)),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(2.0),
                color: Colors.black,
                width: m.width / 10,
                child: InkWell(
                    child: CachedNetworkImage(
                  imageUrl: Url().ddragon +
                      version +
                      '/img/item/' +
                      recommendShoes[i] +
                      '.png',
                  errorWidget: (context, url, error) => Icon(Icons.image),
                  fit: BoxFit.fill,
                ))),
            Container(
              //color: Colors.black45,
              child: Text(
                '',
                // recommendShoesName[i],
                style: TextStyle(color: Color.fromRGBO(242, 226, 5, 1)),
              ),
            ),
          ],
        ));
  }

  Widget recommendShoesList(Size m) {
    return Container(
        //margin: EdgeInsets.fromLTRB(m.width / 30, 0, m.width / 15, 0),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (i = 0; i < recommendShoesName.length; i++)
          Container(
            child: recommendShoesinfo(m, i),
          ),
        /*  Container(
          child: recommendShoesinfo(m, 1),
          margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
        ),
        Container(
          child: recommendShoesinfo(m, 2),
          margin: EdgeInsets.fromLTRB(m.width / 30, 0, 0, 0),
        ), */
      ],
    ));
  }

  void champInfoUrl() async {
    await Future.delayed(const Duration(milliseconds: 600), () async {
      http.Response response;
      String body;

      try {
        response = await http.get(KeyPlus().urlkeyPlus(Url().champInfoListUrl));
        body = utf8.decode(response.bodyBytes);
      } on Exception catch (exception) {
        print('정신병걸릴거같아!!$exception');
        champInfoUrl();
      } catch (error) {
        print('정신병걸릴거같아!!$error');
        champInfoUrl();
      }
      if (response.statusCode == 200) {
        var jsonData = json.decode(body);
        if (mounted) {
          setState(() {
            skillA = List<String>(
                jsonData[widget.champkey]['skilltree'][0].length - 2);
            skillPicRate = jsonData[widget.champkey]['skilltree'][0][3];
            skillWinRate = jsonData[widget.champkey]['skilltree'][0][4];
            for (i = 0; i < skillA.length; i++) {
              skillA[i] = jsonData[widget.champkey]['skilltree'][0][i];
              if (skillA[i] == 'RyzeQ') {
                skillA[i] = 'RyzeQWrapper';
              }
            }
            champName = jsonData[widget.champkey]['name'];
            recommenditemA = List<String>(
                jsonData[widget.champkey]['recommenditem'][0].length);
            for (i = 0; i < recommenditemA.length; i++) {
              recommenditemA[i] =
                  jsonData[widget.champkey]['recommenditem'][0][i];
            }

            recommenditemB = List<String>(
                jsonData[widget.champkey]['recommenditem'][1].length);
            for (i = 0; i < recommenditemB.length; i++) {
              recommenditemB[i] =
                  jsonData[widget.champkey]['recommenditem'][1][i];
            }

            recommendShoes = List<String>(
                jsonData[widget.champkey]['recommendshoes'].length);
            for (i = 0; i < recommendShoes.length; i++) {
              recommendShoes[i] =
                  jsonData[widget.champkey]['recommendshoes'][i];
            }

            startitemA =
                List<String>(jsonData[widget.champkey]['startitem'][0].length);
            for (i = 0; i < startitemA.length; i++) {
              startitemA[i] = jsonData[widget.champkey]['startitem'][0][i];
            }
            startitemAPic = jsonData[widget.champkey]['startitem'][0][6];
            startitemAWin = jsonData[widget.champkey]['startitem'][0][7];

            startitemB =
                List<String>(jsonData[widget.champkey]['startitem'][1].length);
            for (i = 0; i < startitemB.length; i++) {
              startitemB[i] = jsonData[widget.champkey]['startitem'][1][i];
            }
            startitemBPic = jsonData[widget.champkey]['startitem'][1][6];
            startitemBWin = jsonData[widget.champkey]['startitem'][1][7];

            if (champName.isNotEmpty) {
              startitemALength = startitemA.indexOf('null');
              startitemBLength = startitemB.indexOf('null');

              champSkillUrl();
              champitemUrl();
            }
          });
        }
      } else {
        print('champInfoListUrl Error!');
        champInfoUrl();
      }
    });
  }

  void champSkillUrl() async {
    final response = await http.get(Url().ddragon +
        version +
        '/data/ko_KR/champion/' +
        champName +
        '.json');
    String body = '';
    if (response.statusCode == 200) {
      body = utf8.decode(response.bodyBytes);
    } else {
      throw Exception('Error!');
    }
    var jsonData = json.decode(body);
    if (mounted) {
      setState(() {
        skillAId = jsonData['data'][champName]['spells'][0]['id'];
        skillBId = jsonData['data'][champName]['spells'][1]['id'];
        skillCId = jsonData['data'][champName]['spells'][2]['id'];

        if (skillA[0] == skillAId) {
          skillAName = 'Q';
          skillAInfo = jsonData['data'][champName]['spells'][0]['description'];
          skillAInfo = subString.subStringFunction(skillAInfo);
        } else if (skillA[0] == skillBId) {
          skillAName = 'W';
          skillAInfo = jsonData['data'][champName]['spells'][1]['description'];
          skillAInfo = subString.subStringFunction(skillAInfo);
        } else if (skillA[0] == skillCId) {
          skillAName = 'E';
          skillAInfo = jsonData['data'][champName]['spells'][2]['description'];
          skillAInfo = subString.subStringFunction(skillAInfo);
        }

        if (skillA[1] == skillAId) {
          skillBName = 'Q';
          skillBInfo = jsonData['data'][champName]['spells'][0]['description'];
          skillBInfo = subString.subStringFunction(skillBInfo);
        } else if (skillA[1] == skillBId) {
          skillBName = 'W';
          skillBInfo = jsonData['data'][champName]['spells'][1]['description'];
          skillBInfo = subString.subStringFunction(skillBInfo);
        } else if (skillA[2] == skillCId) {
          skillBName = 'E';
          skillBInfo = jsonData['data'][champName]['spells'][2]['description'];
          skillBInfo = subString.subStringFunction(skillBInfo);
        }

        if (skillA[2] == skillAId) {
          skillCName = 'Q';
          skillCInfo = jsonData['data'][champName]['spells'][0]['description'];
          skillCInfo = subString.subStringFunction(skillCInfo);
        } else if (skillA[2] == skillBId) {
          skillCName = 'W';
          skillCInfo = jsonData['data'][champName]['spells'][1]['description'];
          skillCInfo = subString.subStringFunction(skillCInfo);
        } else if (skillA[2] == skillCId) {
          skillCName = 'E';
          skillCInfo = jsonData['data'][champName]['spells'][2]['description'];
          skillCInfo = subString.subStringFunction(skillCInfo);
        }
      });
      print(skillAId + '=' + skillA[0]);
      print(skillBId + '=' + skillA[1]);
      print(skillCId + '=' + skillA[2]);
    }
  }

  champitemUrl() async {
    final response =
        await http.get(Url().ddragon + version + '/data/ko_KR/item.json');
    String body = '';
    if (response.statusCode == 200) {
      body = utf8.decode(response.bodyBytes);
    } else {
      throw Exception('Error!');
    }
    var jsonData = json.decode(body);
    if (mounted) {
      setState(() {
        recommenditemAName = List<String>(recommenditemA.length);
        recommenditemADescription = List<String>(recommenditemA.length);
        recommenditemAGoldBase = List<String>(recommenditemA.length);
        recommenditemAGoldTotal = List<String>(recommenditemA.length);

        for (i = 0; i < recommenditemA.length - 2; i++) {
          recommenditemAName[i] = jsonData['data'][recommenditemA[i]]['name'];
          recommenditemADescription[i] =
              jsonData['data'][recommenditemA[i]]['description'];
          recommenditemADescription[i] =
              subString.subStringFunction(recommenditemADescription[i]);
          recommenditemAGoldBase[i] =
              jsonData['data'][recommenditemA[i]]['gold']['base'].toString();
          recommenditemAGoldTotal[i] =
              jsonData['data'][recommenditemA[i]]['gold']['total'].toString();
        }
        recommenditemBName = List<String>(recommenditemB.length);
        recommenditemBDescription = List<String>(recommenditemB.length);
        recommenditemBGoldBase = List<String>(recommenditemB.length);
        recommenditemBGoldTotal = List<String>(recommenditemB.length);

        for (i = 0; i < recommenditemB.length - 2; i++) {
          recommenditemBName[i] = jsonData['data'][recommenditemB[i]]['name'];
          recommenditemBDescription[i] =
              jsonData['data'][recommenditemB[i]]['description'];
          recommenditemBDescription[i] =
              subString.subStringFunction(recommenditemBDescription[i]);
          recommenditemBGoldBase[i] =
              jsonData['data'][recommenditemB[i]]['gold']['base'].toString();
          recommenditemBGoldTotal[i] =
              jsonData['data'][recommenditemB[i]]['gold']['total'].toString();
        }

        recommendShoesName = List<String>(recommendShoes.length);
        recommendShoesDescription = List<String>(recommendShoes.length);
        recommendShoesGoldBase = List<String>(recommendShoes.length);
        recommendShoesGoldTotal = List<String>(recommendShoes.length);

        for (i = 0; i < recommendShoes.length; i++) {
          recommendShoesName[i] = jsonData['data'][recommendShoes[i]]['name'];
          recommendShoesDescription[i] =
              jsonData['data'][recommendShoes[i]]['description'];
          recommendShoesDescription[i] =
              subString.subStringFunction(recommendShoesDescription[i]);
          recommendShoesGoldBase[i] =
              jsonData['data'][recommendShoes[i]]['gold']['base'].toString();
          recommendShoesGoldTotal[i] =
              jsonData['data'][recommendShoes[i]]['gold']['total'].toString();
        }

        startitemAName = List<String>(startitemALength);
        startitemADescription = List<String>(startitemALength);
        startitemAGoldBase = List<String>(startitemALength);
        startitemAGoldTotal = List<String>(startitemALength);

        for (i = 0; i < startitemALength; i++) {
          startitemAName[i] = jsonData['data'][startitemA[i]]['name'];
          startitemADescription[i] =
              jsonData['data'][startitemA[i]]['description'];
          startitemADescription[i] =
              subString.subStringFunction(startitemADescription[i]);
          startitemAGoldBase[i] =
              jsonData['data'][startitemA[i]]['gold']['base'].toString();
          startitemAGoldTotal[i] =
              jsonData['data'][startitemA[i]]['gold']['total'].toString();
        }

        startitemBName = List<String>(startitemBLength);
        startitemBDescription = List<String>(startitemBLength);
        startitemBGoldBase = List<String>(startitemBLength);
        startitemBGoldTotal = List<String>(startitemBLength);

        for (i = 0; i < startitemBLength; i++) {
          startitemBName[i] = jsonData['data'][startitemB[i]]['name'];
          startitemBDescription[i] =
              jsonData['data'][startitemB[i]]['description'];
          startitemBDescription[i] =
              subString.subStringFunction(startitemBDescription[i]);
          startitemBGoldBase[i] =
              jsonData['data'][startitemB[i]]['gold']['base'].toString();
          startitemBGoldTotal[i] =
              jsonData['data'][startitemB[i]]['gold']['total'].toString();
        }
      });
    }
  }
}
