import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'champ_spell.dart';
import 'champ_counter.dart';
import 'champ_rune.dart';
import 'champ_skill.dart';
import 'champlist.dart';
import 'package:http/http.dart' as http;
import 'package:gaap/Url_List.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

class ChampRecommend extends StatefulWidget {
  final String name;
  ChampRecommend({Key key, this.name, title: '챔피언공략'}) : super(key: key);
  @override
  _ChampRecommendState createState() => _ChampRecommendState();
}

class _ChampRecommendState extends State<ChampRecommend>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int cnt = 0;
  var name = '';
  var champImg = '';
  var champcountername = '';
  var champName = '';
  var champKey = '';
  var champTitle = '';
  var champSpellA = '';
  var champSpellB = '';
  var champSpellPic = '';
  var champSpellWin = '';
  var champWinRate = '';
  var champBanRate = '';
  var champposition = '';
  var spellA = '';
  var spellB = '';

  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    championInfo();
  }

  @override
  Widget build(BuildContext context) {
    print(
        '-----------------------------ChampRecommend start-----------------------');
    name = widget.name;
    var m = MediaQuery.of(context).size;
    return Scaffold(
        //backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            /*      Container(
              color: Colors.white,
              height: MediaQuery.of(context).padding.top,
            ), */
            Container(
                height: m.height,
                child: champImg.isNotEmpty
                    ? CustomScrollView(
                        slivers: _sliverList(m, champImg, champTitle, champKey,
                            champcountername, version))
                    : Container()),
          ],
        ),
        ad()
      ],
    ));
  }

  Widget ad() {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);

    var m = (MediaQuery.of(context).size);

    return Positioned(
      bottom: 0,
      width: m.width,
      child: Container(
        color: Colors.white,
        height: m.height * 0.1,
        child: NativeAdmob(
          adUnitID: providerCheckOS.getadUnitID,
          controller: _nativeAdController,
          loading: Container(),
          error: Text('광고 표시 오류'),
          type: NativeAdmobType.banner,
        ),
      ),
    );
  }

  List<Widget> _sliverList(Size m, String champImg, String champTitle,
      String champKey, String champcountername, String version) {
    var widgetList = new List<Widget>();
    for (int index = 0; index < 1; index++)
      widgetList
        ..add(SliverAppBar(
            elevation: 15,
            shape: ContinuousRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(2, 6, 89, 0.5), width: 2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            //titleSpacing: m.width / 3,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            //title: championAll(m, champImg, champTitle),
            pinned: true,
            bottom: PreferredSize(
              // Add this code
              preferredSize: Size.fromHeight(m.width / 13), // Add this code
              child: championAll(m, champImg, champTitle),
            )
            //floating: true,
            ))
        ..add(SliverPrototypeExtentList(
          // SliverPrototypeExtentList -> 미리 요소 높이 측정
          // SliverFixedExtentList -> 높이 직접 줌
          //itemExtent: m.height * 2.6,
          prototypeItem: Container(
            child: Column(
              children: <Widget>[
                Card(
                    shadowColor: Color.fromRGBO(2, 6, 89, 1),
                    margin: EdgeInsets.all(15),
                    elevation: 5,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: ChampCounter(champKey, champcountername))),
                Card(
                    shadowColor: Color.fromRGBO(2, 6, 89, 1),
                    elevation: 5,
                    color: Colors.white,
                    margin: EdgeInsets.all(15),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: ChampRune(champKey))),
                Card(
                    shadowColor: Color.fromRGBO(2, 6, 89, 1),
                    elevation: 5,
                    color: Colors.white,
                    margin: EdgeInsets.all(15),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: ChampSpell(champKey))),
                Card(
                    margin: EdgeInsets.all(15),
                    shadowColor: Color.fromRGBO(2, 6, 89, 1),
                    elevation: 5,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: ChampSkill(champKey))),
              ],
            ),
          ),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              child: Column(
                children: <Widget>[
                  Card(
                      shape: ContinuousRectangleBorder(
                        side: BorderSide(color: Colors.yellow[600], width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadowColor: Color.fromRGBO(2, 6, 89, 1),
                      margin: EdgeInsets.all(15),
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: ChampCounter(champKey, champcountername))),
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
                          child: ChampRune(champKey))),
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
                          child: ChampSpell(champKey))),
                  ChampSkill(champKey)
                ],
              ),
            );
          }, childCount: 1),
        ));

    return widgetList;
  }

  Widget championAll(Size m, String champImg, String champTitle) {
    return Container(
        margin:
            EdgeInsets.fromLTRB(m.width / 30, m.width / 80, m.width / 30, 0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(10),
        //   ),
        //     border: Border.all(
        //       width: 3.0
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                champion(m, champImg),
                championNT(m, champName, champTitle),
              ],
            ),
            //Container(width: m.width/6),
            champRate(m)
          ],
        ));
  }

  Widget champRate(Size m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(
              m.height / 40.0, m.height / 100.0, m.height / 50.0, 1.1),
          child: Text(
            '승률       ' + champWinRate,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: m.width / 30),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              m.height / 40.0, m.height / 100.0, m.height / 50.0, 5),
          child: Text(
            '밴률       ' + champBanRate,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: m.width / 30),
          ),
        ),
      ],
    );
  }

  Widget championNT(Size m, String champName, String champTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        championName(m, champName),
        championTitle(m, champTitle),
      ],
    );
  }

  Widget championName(Size m, String champName) {
    return Container(
      // color: Color.fromRGBO(2, 6, 89, 0.5),
      margin: EdgeInsets.fromLTRB(m.height / 60, 2, 10, m.height / 100),
      child: Text(
        champName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(2, 6, 89, 1),
          fontSize: m.height / 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget championTitle(Size m, String champTitle) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      margin: EdgeInsets.fromLTRB(m.height / 60, 1.5, 30, m.height / 200),
      child: Text(
        champTitle,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.black87, fontSize: m.height / 60),
      ),
    );
  }

  Widget champion(Size m, String champImg) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          m.height / 50, m.height / 100, m.height / 50, m.height / 100),
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return Champlist();
            }));
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                child: CachedNetworkImage(
                  imageUrl: 'http://ddragon.leagueoflegends.com/cdn/' +
                      version +
                      '/img/champion/' +
                      champImg,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                  width: (MediaQuery.of(context).size.width) / 7,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                margin: EdgeInsets.all(2),
                child: Text(
                  champposition,
                  style: TextStyle(
                      fontSize: m.width / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  Widget tabbar1(Size m) {
    return Container(
      width: m.width,
      decoration: BoxDecoration(color: Color.fromRGBO(242, 226, 5, 1)),
      child: TabBar(
          unselectedLabelColor: Color.fromRGBO(2, 6, 89, 0.5),
          labelColor: Color.fromRGBO(2, 6, 89, 1),
          tabs: [
            Container(
              alignment: Alignment.center,
              height: m.height / 20,
              child: Text(
                '추천 룬',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: m.height / 20,
              child: Text(
                '스펠',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: m.height / 20,
              child: Text(
                '챔프 상성',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: m.height / 20,
              child: Text(
                '아이템',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            /*     Tab(text: '추천 룬'),
                        Tab(text: '스펠&스킬'),
                        Tab(text: '챔프 상성'),
                        Tab(text: '아이템'), */
          ],
          controller: _tabController,
          indicatorColor: Color.fromRGBO(2, 6, 89, 1),
          indicatorSize: TabBarIndicatorSize.tab),
    );
  }

  Widget tabbarviewe(
      Size m, String champKey, String version, String champcountername) {
    return Expanded(
        child: Container(
            /*   width: m.width,
                          height: m.height * 0.7, */
            //constraints: BoxConstraints(maxHeight: m.height * 0.65),
            color: Color.fromRGBO(255, 255, 255, 1),
            child: TabBarView(
              controller: _tabController,
              children: [
                //ChampCounter(),
                Container(child: ChampRune(champKey)),
                Container(child: ChampSpell(champKey)),
                Container(child: ChampCounter(champKey, champcountername)),
                Container(child: ChampSkill(champKey)),
              ],
            )));
  }

  bool champState = false;
  champ() async {
    print('champ() start');
    try {
      http.Response response;
      String body;
      response = await http.get(KeyPlus().urlkeyPlus(Url().champInfoListUrl));
      body = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonData = json.decode(body);
        if (mounted) {
          champWinRate = jsonData[champKey]['winrate'];
          champBanRate = jsonData[champKey]['banrate'];
          champSpellA = jsonData[champKey]['recommendspell'][0]['spellA'];
          champSpellB = jsonData[champKey]['recommendspell'][0]['spellB'];
          champSpellPic = jsonData[champKey]['recommendspell'][0]['spellpic'];
          champSpellWin = jsonData[champKey]['recommendspell'][0]['spellwin'];
          champposition = jsonData[champKey]['position'];

          if (champposition == 'top') {
            champposition = '탑';
          } else if (champposition == 'mid') {
            champposition = '미드';
          } else if (champposition == 'jungle') {
            champposition = '정글';
          } else if (champposition == 'support') {
            champposition = '서포터';
          } else {
            champposition = '원딜';
          }
          spellA =
              Url().ddragon + version + '/img/spell/' + champSpellA + '.png';

          spellB =
              Url().ddragon + version + '/img/spell/' + champSpellB + '.png';
          print('champState true');
          setState(() {
            champState = true;
          });
        }
      } else {
        print('Fail');
      }
    } catch (e) {
      print('champ() error = $e');
      champ();
    }
  }

  bool champInfoState = true;
  Future<dynamic> championInfo() async {
    print('champInfo() Start');
    http.Response response =
        await http.get(Url().ddragon + version + '/data/ko_KR/champion.json');
    String body = '';
    if (response.statusCode == 200) {
      body = utf8.decode(response.bodyBytes);
      var jsonData = json.decode(body);
      if (mounted) {
        champImg = jsonData['data'][widget.name]["image"]['full'].toString();
        champcountername = jsonData['data'][widget.name]['id'].toString();
        champName = jsonData['data'][widget.name]['name'].toString();
        champTitle = jsonData['data'][widget.name]['title'].toString();
        champKey = jsonData['data'][widget.name]['key'];
        print('챔프 이름 = $champcountername');
        print('champInfoState false');
        champInfoState = false;
        if (champInfoState == false) {
          champ();
        }
      }
    } else {
      print('response Fail');
      championInfo();
    }
  }
}
