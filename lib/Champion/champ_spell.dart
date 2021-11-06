import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gaap/Url_List.dart';

class ChampSpell extends StatefulWidget {
  final String champKey;
  ChampSpell(this.champKey);
  @override
  createState() => new ChampSpellState();
}

class ChampSpellState extends State<ChampSpell>
    with AutomaticKeepAliveClientMixin {
  var url = '';
  var champNumber = '';
  var champkey = '';
  var champSpellA = '';
  var champSpellB = '';
  var champSpellPic = '';
  var champSpellWin = '';
  var champWinRate = '';
  var champBanRate = '';
  var champposition = '';
  var spellA = '';
  var spellB = '';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    champ();
  }

  @override
  Widget build(BuildContext context) {
    print('champSpellA = $champSpellA');
    super.build(context);
    var m = (MediaQuery.of(context).size);
    champkey = widget.champKey;
    print('champWinRate = $champWinRate');
    return champSpellWin != ''
        ? Container(
            child: Column(
            children: <Widget>[
              //챔프 스펠
              Column(
                children: <Widget>[
                  title(m),
                  //포지션
                  /* winrate(),
                  banrate(), */
                  Container(
                    child: Row(
                      children: <Widget>[
                        //이미지
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              m.width / 30, m.height / 70, m.width / 30, 0.0),
                          width: m.width / 8,
                          //height: 40,
                          color: Colors.black,
                          padding: EdgeInsets.all(2.0),
                          child: InkWell(
                            child: CachedNetworkImage(
                              imageUrl: spellA,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(242, 242, 242, 1),
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color.fromRGBO(242, 226, 5, 1))),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image),
                              fit: BoxFit.fill,
                              width: (MediaQuery.of(context).size.width) / 5,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0.0, m.height / 70, m.width / 4, 0.0),
                          width: m.width / 8,
                          //height: 40,
                          color: Colors.black,
                          padding: EdgeInsets.all(2.0),
                          child: InkWell(
                            child: CachedNetworkImage(
                              imageUrl: spellB,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(242, 242, 242, 1),
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color.fromRGBO(242, 226, 5, 1))),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image),
                              fit: BoxFit.fill,
                              width: (MediaQuery.of(context).size.width) / 5,
                            ),
                          ),
                        ),
                        //텍스트
                        champSpellWin == ''
                            ? Container(
                                width:
                                    (MediaQuery.of(context).size.width) * 0.3,
                                height: 10,
                                child: LinearProgressIndicator(
                                    backgroundColor:
                                        Color.fromRGBO(242, 242, 242, 1),
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Color.fromRGBO(242, 226, 5, 1))))
                            : Container(
                                margin:
                                    EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 0.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '승률 : ' + champSpellWin,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: m.height / 60),
                                    ),
                                    Text(
                                      '픽률 : ' + champSpellPic,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: m.height / 60),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ))
        : Container(
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

  Widget title(Size m) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '소환사 주문',
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

  Widget winrate() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0.0),
            width: 40,
            height: 40,
            child: InkWell(
              child: Image.asset('images/etc/Position_Gold-Mid.png'),
            ),
          ),
          champWinRate == ''
              ? Container(
                  width: (MediaQuery.of(context).size.width) * 0.3,
                  height: 10,
                  child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(242, 226, 5, 1))))
              : Container(
                  margin: EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0.0),
                  child: Text(
                    '승률 : ' + champWinRate,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
        ],
      ),
    );
  }

  Widget banrate() {
    return Container(
      child: Row(
        children: <Widget>[
          //이미지
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0.0),
            width: 40,
            height: 40,
            child: InkWell(
              child: Image.asset('images/etc/Position_Gold-Jungle.png'),
            ),
          ),
          //텍스트
          champBanRate == ''
              ? Container(
                  width: (MediaQuery.of(context).size.width) * 0.3,
                  height: 10,
                  child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(242, 226, 5, 1))))
              : Container(
                  margin: EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 0.0),
                  child: Text(
                    '밴률 : ' + champBanRate,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
        ],
      ),
    );
  }

  champ() async {
    await Future.delayed(const Duration(milliseconds: 400), () async {
      http.Response response;
      String body;

      response = await http.get(KeyPlus().urlkeyPlus(Url().champInfoListUrl));
      body = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonData = json.decode(body);
        if (mounted) {
          setState(() {
            champWinRate = jsonData[champkey]['winrate'];
            champBanRate = jsonData[champkey]['banrate'];
            champNumber = jsonData[champkey]['name'];
            champSpellA = jsonData[champkey]['recommendspell'][0]['spellA'];
            champSpellB = jsonData[champkey]['recommendspell'][0]['spellB'];
            champSpellPic = jsonData[champkey]['recommendspell'][0]['spellpic'];
            champSpellWin = jsonData[champkey]['recommendspell'][0]['spellwin'];

            spellA =
                Url().ddragon + version + '/img/spell/' + champSpellA + '.png';

            spellB =
                Url().ddragon + version + '/img/spell/' + champSpellB + '.png';
          });
        }
      } else {
        print('Fail');
        champ();
      }
    });
  }
}
