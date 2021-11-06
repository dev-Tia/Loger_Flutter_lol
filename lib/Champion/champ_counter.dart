import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gaap/Url_List.dart';
//import 'package:gaap/Record_value.dart';
import 'champ_recommend.dart';

class ChampCounter<T> extends StatefulWidget {
  final String champkey;
  final String name;
  ChampCounter(this.champkey, this.name);

  @override
  createState() => new ChampCounterState();
}

class ChampCounterState<T> extends State<ChampCounter<T>>
    with AutomaticKeepAliveClientMixin {
  List<String> easyChampName = [];
  List<String> easyChampRate = [];
  List<String> easyChampKoName = [];
  List<String> hardChampName = [];
  List<String> hardChampRate = [];
  List<String> hardChampKoName = [];

  var i = 0;
  var champlength = 0;
  bool easyChampNameState = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    champInfoUrl();
  }

  @override
  Widget build(BuildContext context) {
    print('------------------------ChampCounter Start----------------------');
    super.build(context);
    var m = MediaQuery.of(context).size;
    return Container(
        child: Column(
      children: <Widget>[
        //제목
        title(m, '상대하기 좋은 챔피언'),
        Container(height: m.height / 40),
        champInfoUrlState == false
            ? easyChampList(m, version)
            : easyChampName == null
                ? Container(child: Text('없대요'))
                : loading(m),
        Container(height: m.height / 20),
        title(m, '상대하기 힘든 챔피언'),
        Container(height: m.height / 40),
        champInfoUrlState == false
            ? hardChampList(m, version)
            : hardChampName == null
                ? Container(child: Text('없대요'))
                : loading(m),
      ],
    ));
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

  Widget loading(Size m) {
    return Container(
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

  Widget textbar(Size m) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          m.height / 50, m.height / 50, m.height / 50, m.height / 50),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: Color.fromRGBO(2, 6, 89, 1),
        )),
      ),
    );
  }

  Widget textLine(String text, Size m) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, m.height / 30, 0, m.height / 30),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: m.height / 40),
      ),
    );
  }

  Widget easyChampList(Size m, String version) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        easyChampName == null
            ? Container(
                width: 1,
                height: 1,
              )
            : easyChampName.length != 1
                ? easyChamp(m, version, 0)
                : easyChamp(m, version, 0),
        easyChampName.length == 2
            ? easyChamp(m, version, 1)
            : easyChampName.length != 1
                ? easyChamp(m, version, 1)
                : Container(),
        easyChampName.length == 3
            ? easyChamp(m, version, 2)
            : easyChampName.length == 2
                ? Container()
                : easyChampName.length != 1
                    ? easyChamp(m, version, 2)
                    : Container()
      ],
    );
  }

  Widget easyChamp(Size m, String version, int i) {
    return easyChampName[i].isNotEmpty
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
            Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(m.width / 50, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        m.width / 30, 0, m.width / 30, m.height / 80),
                    //width: m.width / 5,
                    child: InkWell(
                      child: CachedNetworkImage(
                        imageUrl: Url().ddragon +
                            version +
                            '/img/champion/' +
                            easyChampName[i] +
                            '.png',
                        width: m.width / 10,
                        errorWidget: (context, url, error) => Icon(Icons.image),
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChampRecommend(name: easyChampName[i]),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(
                        m.width / 30, 0, m.width / 30, m.height / 80),
                    child: Text(
                      easyChampKoName[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontSize: m.height / 50),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, m.width / 30, m.height / 80),
              child: Text(
                '승률    ' + easyChampRate[i],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: m.height / 50),
              ),
            ),
          ])
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                  width: m.width / 5,
                  child: InkWell(
                    child: Icon(Icons.image),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, m.height / 50, 0, 0.0),
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.blue, fontSize: m.height / 50),
                  ),
                ),
              ]);
  }

  Widget hardChampList(Size m, String version) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        hardChampName == null
            ? Container(
                width: 1,
                height: 1,
              )
            : hardChampName.length != 1
                ? hardChamp(m, version, 0)
                : hardChamp(m, version, 0),
        hardChampName.length == 2
            ? hardChamp(m, version, 1)
            : hardChampName.length != 1
                ? hardChamp(m, version, 1)
                : Container(),
        hardChampName.length == 3
            ? hardChamp(m, version, 2)
            : hardChampName.length == 2
                ? Container()
                : hardChampName.length != 1
                    ? hardChamp(m, version, 2)
                    : Container()
      ],
    );
  }

  Widget hardChamp(Size m, String version, int i) {
    return champInfoUrlState == false
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
            Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(m.width / 50, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        m.width / 30, 0, m.width / 30, m.height / 80),
                    //width: m.width / 5,
                    child: InkWell(
                      child: CachedNetworkImage(
                        imageUrl: Url().ddragon +
                            version +
                            '/img/champion/' +
                            hardChampName[i] +
                            '.png',
                        errorWidget: (context, url, error) => Icon(Icons.image),
                        width: m.width / 10,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChampRecommend(name: hardChampName[i]),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(
                        m.width / 30, 0, m.width / 30, m.height / 80),
                    child: Text(
                      hardChampKoName[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontSize: m.height / 50),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, m.width / 30, m.height / 80),
              child: Text(
                '승률    ' + hardChampRate[i],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: m.height / 50),
              ),
            ),
          ])
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                  width: m.width / 5,
                  child: InkWell(
                    child: Icon(Icons.image),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, m.height / 50, 0, 0.0),
                  child: Text(
                    '',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.black, fontSize: m.height / 50),
                  ),
                ),
              ]);
  }

  bool champInfoUrlState = true;
  void champInfoUrl() async {
    print('ChampCounter champInfoUrl() start');
    print('easyChampName start = $easyChampName');
    http.Response response;
    String body;
    try {
      await Future.delayed(const Duration(milliseconds: 200), () async {
        response = await http.get(KeyPlus().urlkeyPlus(Url().champInfoListUrl));
        body = utf8.decode(response.bodyBytes);
        if (response.statusCode == 200) {
          var jsonData = json.decode(body);
          champlength = jsonData[widget.champkey]['easychamp'].length;
          easyChampName = List<String>(champlength);
          easyChampRate = List<String>(champlength);
          easyChampKoName = List<String>(champlength);

          hardChampName = List<String>(champlength);
          hardChampRate = List<String>(champlength);
          hardChampKoName = List<String>(champlength);

          for (i = 0; i < jsonData[widget.champkey]['easychamp'].length; i++) {
            easyChampName[i] =
                jsonData[widget.champkey]['easychamp'][i]['name'];
            easyChampKoName[i] =
                jsonData[widget.champkey]['easychamp'][i]['koName'];

            easyChampRate[i] =
                jsonData[widget.champkey]['easychamp'][i]['winrate'];
          }

          for (i = 0; i < jsonData[widget.champkey]['hardchamp'].length; i++) {
            hardChampName[i] =
                jsonData[widget.champkey]['hardchamp'][i]['name'];
            hardChampKoName[i] =
                jsonData[widget.champkey]['hardchamp'][i]['koName'];

            hardChampRate[i] =
                jsonData[widget.champkey]['hardchamp'][i]['winrate'];
          }
          print('쉬운 챔피언 = $easyChampName');
          print('어려운 챔피언 = $hardChampName');
          print('champInfoUrlState false');

          if (mounted) {
            setState(() {
              champInfoUrlState = false;
            });
          }
        } else {
          throw Exception('Fail');
        }
      });
    } catch (e) {
      print('champInfoUrl() response error $e');
      champInfoUrl();
    }
  }
}
