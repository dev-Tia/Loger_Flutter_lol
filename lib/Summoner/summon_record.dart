import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:gaap/Providers/MatchProvider.dart';
import 'package:gaap/Url_List.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:provider/provider.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:gaap/Providers/SummerProvider.dart';
import 'package:gaap/Providers/CheckProvider.dart';
import 'package:gaap/Match/Summoner_Match.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class SummonerRec extends StatefulWidget {
  @override
  SommonerPageState createState() => SommonerPageState();
}

class SommonerPageState extends State<SummonerRec>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AnimationController _animationController;
  Animation _animation;

  TabController _tabController;
  final myController = TextEditingController();
  final _nativeAdController = NativeAdmobController();

  int j = 0;
  String version = '';
  String a = '';

  double val = 0;
  String noName = '소환사를 검색해 주세요';
  int tbc = 0;

  String summonerName = '';

  String getName = '';
  String getIcon = '';
  String getLevel = '';

  String tierSolo = '';
  String tierFlex = '';

  String allWinRateWin = '';
  String allWinRateLose = '';
  String allWinRateRate = '';

  String soloWinRateWin = '';
  String soloWinRateLose = '';
  String soloWinRateRate = '';

  String flexWinRateWin = '';
  String flexWinRateLose = '';
  String flexWinRateRate = '';

  String avgKills = '';
  String avgDeaths = '';
  String avgAssists = '';

  String mainPosition = '';
  String mainPositionRate = '';
  String subPosition = '';
  String subPositionRate = '';

  int historyLength = 0;
  List<String> historyQT = [];
  List<String> historyWin = [];
  List<String> historyChamp = [];
  List<String> historyKoChamp = [];

  List<String> historyK = [];
  List<String> historyD = [];
  List<String> historyA = [];
  List<String> historyCS = [];
  List<String> historyGC = [];
  List<String> historyGD = [];
  List<String> historyRuneA = [];
  List<String> historyRuneAIcon = [];
  List<String> historyRuneB = [];
  List<String> historyRuneBIcon = [];
  List<String> historySpellA = [];
  List<String> historySpellB = [];
  List<List> historyItem = [];
  List<String> historyAccs = [];
  List<List> historyItemKo = [];
  int index = 0;
  int mainChampionLength = 0;
  List<String> mainChampionName = [];
  List<String> mainChampionKoName = [];
  List<String> mainChampionWin = [];
  List<String> mainChampionLose = [];
  List<String> mainChampionRate = [];
  List<String> mainChampionK = [];
  List<String> mainChampionD = [];
  List<String> mainChampionA = [];
  List<int> gameId = [];
  ScrollController _scrollController;
  bool _isloading = true;
  bool loadingState = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    //print(summonerName);
    fetchVersion();
    //myController.text = getName;
    tierFlex = '';
    a = myController.text;
    tbc = 0;
    //champ(a);
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );

    super.initState();

    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = IntTween(begin: 100, end: 0).animate(_animationController);
    _animation.addListener(() => setState(() {
          print(
              '#############################################################1');
        }));
  }

/*   void _toStart() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  } */

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('----------------------소환사 정보 ---------------------');
    print('passKeyFlutter = $passKeyFlutter');
    super.build(context);

    var m = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
            alignment: Alignment.topCenter,
            height: m.height + m.height * 0.6,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    width: m.width,
                    //height: m.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Row(
                        //   children: <Widget>[
                        //     chsName(),
                        //     myRnk(),
                        //   ],
                        // ),
                        // refreshBtn(),
                        loadingState
                            ? Column(
                                children: <Widget>[
                                  Container(
                                      height: m.width / 6,
                                      color: Colors.black.withOpacity(0.0)),
                                  iconAndTier(m),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      avgKDA(m),
                                      positionList(m),
                                    ],
                                  ),
                                  // refeshNschIcon(), //
                                ],
                              )
                            : _isloading ? searchiing() : Container(),
                        textinput(myController.text),
                        loadingState
                            ? Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, m.height * 0.01, 0, 0),
                                      child: Text(
                                        '선호 챔피언',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: m.height * 0.025),
                                      )),
                                  mainChampionList(m),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, m.width / 30, 0, m.width / 30),
                                    /*  child: ChampSkillState().title(m, '최근 전적') */
                                  ),
                                  /*  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    height: m.height * 0.45,
                                    child: historyRuneAIcon.isNotEmpty
                                        ? CustomScrollView(
                                            slivers: _sliverList(m))
                                        : Container()), */

                                  Column(
                                    children: <Widget>[
                                      for (index = 0;
                                          index < historyLength;
                                          index++)
                                        historyview(index)
                                    ],
                                  ),
                                  SizedBox(height: m.width / 7)
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //     width: m.width / 8,
                //     height: m.width / 8,
                //     bottom: m.width / 20,
                //     right: m.width / 20,
                //     child: FloatingActionButton(
                //         backgroundColor: Color.fromRGBO(2, 6, 89, 0.7),
                //         onPressed: () {},
                //         child: IconButton(
                //             icon: new Icon(Icons.arrow_upward),
                //             onPressed: () {
                //               _toStart();
                //             })))
              ],
            )),
      ),
    );
  }

  /* List<Widget> _sliverList(Size m) {
    var widgetList = new List<Widget>();
    for (int index = 0; index < 1; index++)
      widgetList
        ..add(SliverAppBar(
            //titleSpacing: m.width / 3,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            //title: championAll(m, champImg, champTitle),
            pinned: true,
            bottom: PreferredSize(
              // Add this code
              preferredSize: Size.fromHeight(m.height / 25), // Add this code
              child: Text('test'),
            )
            //floating: true,
            ))
        ..add(SliverPrototypeExtentList(
          // SliverPrototypeExtentList -> 미리 요소 높이 측정
          // SliverFixedExtentList -> 높이 직접 줌
          //itemExtent: m.height * 2,
          prototypeItem: Container(
            margin: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Container(child: historyview(0)),
              ],
            ),
          ),
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int historyLength) {
            return Container(
              margin: EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Container(child: historyview(historyLength)),
                ],
              ),
            );
          }, childCount: historyLength),
        ));

    return widgetList;
  }
 */

  Widget historyview(int i) {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);

    print('historyview() start');
    if (historyWin[i] == 'true') {
      historyWin[i] = '승';
    } else if (historyWin[i] == 'false') {
      historyWin[i] = '패';
    }
    if (historySpellA.isNotEmpty) {}
    if (historySpellB.isNotEmpty) {}
    var m = MediaQuery.of(context).size;
    return historySpellA.isNotEmpty
        ? Column(
            children: <Widget>[
              i == (i / 9).round() * 9
                  ? Card(
                      shadowColor: Color.fromRGBO(2, 6, 89, 1),
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.yellow[600], width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.fromLTRB(
                        (m.width).round() / 20,
                        0,
                        (m.width).round() / 20,
                        (m.height).round() / 70,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        height: m.height * 0.09,
                        //width: 200,
                        child: NativeAdmob(
                          adUnitID: providerCheckOS.getadUnitID,
                          controller: _nativeAdController,
                          type: NativeAdmobType.banner,
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                child: Card(
                  shadowColor: Color.fromRGBO(2, 6, 89, 1),
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.yellow[600], width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.fromLTRB(
                    (m.width).round() / 20,
                    0,
                    (m.width).round() / 20,
                    (m.height).round() / 70,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: historyWin[i] == '승'
                          ? Colors.blue[50]
                          : Colors.red[50],
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, m.width / 150),
                    padding: EdgeInsets.all(2),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: m.width / 6,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    historyWin[i].toString(),
                                    style: TextStyle(
                                        color: historyWin[i] == '승'
                                            ? Colors.blue
                                            : Colors.red),
                                  ),
                                  Text(historyQT[i].toString(),
                                      style: TextStyle(
                                        fontSize: m.width / 35,
                                      )),
                                  Text(historyGC[i].toString(),
                                      style: TextStyle(
                                        fontSize: m.width / 35,
                                      )),
                                  Text(historyGD[i].toString(),
                                      style: TextStyle(
                                        fontSize: m.width / 35,
                                      )),
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0,
                                                m.width / 100,
                                                0,
                                                m.width / 100),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                9,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'http://ddragon.leagueoflegends.com/cdn/' +
                                                        version +
                                                        '/img/champion/' +
                                                        historyChamp[i] +
                                                        '.png',
                                                /* placeholder: (context, url) =>
                                CircularProgressIndicator(), */
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.image),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0,
                                                m.width / 100,
                                                0,
                                                m.width / 100),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                20,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: CachedNetworkImage(
                                                imageUrl: Url().ddragon +
                                                    version +
                                                    '/img/spell/' +
                                                    historySpellA[i] +
                                                    '.png',
                                                /* placeholder: (context, url) =>
                                CircularProgressIndicator(), */
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0,
                                                m.width / 100,
                                                0,
                                                m.width / 100),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                20,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: CachedNetworkImage(
                                                imageUrl: Url().ddragon +
                                                    version +
                                                    '/img/spell/' +
                                                    historySpellB[i] +
                                                    '.png',
                                                /* placeholder: (context, url) =>
                                CircularProgressIndicator(), */
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width) /
                                              80,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0,
                                                m.width / 100,
                                                0,
                                                m.width / 100),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                20,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: CachedNetworkImage(
                                                imageUrl: Url().ddragon +
                                                    'img/' +
                                                    historyRuneAIcon[i],
                                                /* placeholder: (context, url) =>
                                CircularProgressIndicator(), */
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                              20,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: CachedNetworkImage(
                                              imageUrl: Url().ddragon +
                                                  'img/' +
                                                  historyRuneBIcon[i],
                                              /*  placeholder: (context, url) =>
                                CircularProgressIndicator(), */
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                height: (MediaQuery.of(context)
                                                        .size
                                                        .width) /
                                                    20,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, m.width / 80, 0, m.width / 80),
                                  child: Text(
                                    historyKoChamp[i].toString(),
                                    style: TextStyle(
                                        fontSize: m.width / 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      m.width / 30, 0, m.width / 30, 0),
                                  child: Text(
                                    '평균 CS',
                                    style: TextStyle(
                                        fontSize: m.width / 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      m.width / 20, 0, m.width / 20, 0),
                                  child: Text(
                                    historyCS[i],
                                    style: TextStyle(
                                        fontSize: m.width / 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, m.width / 80),
                                  //width: m.width / 6,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        historyK[i] + '/',
                                        style: TextStyle(
                                          fontSize: m.width / 35,
                                        ),
                                      ),
                                      Text(
                                        historyD[i],
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: m.width / 35,
                                        ),
                                      ),
                                      Text(
                                        '/' + historyA[i],
                                        style: TextStyle(
                                          fontSize: m.width / 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: Colors.white.withOpacity(0.6),
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    callItem(i, 0),
                                    callItem(i, 1),
                                    callItem(i, 2),
                                  ]),
                                  Row(children: <Widget>[
                                    callItem(i, 3),
                                    callItem(i, 4),
                                    callItem(i, 5),
                                  ]),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                        color: Colors.white.withOpacity(0.6),
                                        child: callAccs(i)),
                                  ]),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            //color: Colors.black.withOpacity(0.4),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                15,
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  final providerMatch =
                      Provider.of<MatchProvider>(context, listen: false);
                  providerMatch.inputgameId(gameId[i]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Match(gameId[i], historyWin[i],
                            historyQT[i], historyGC[i], historyGD[i], getName)),
                  );
                },
              ),
            ],
          )
        : Container();
  }

  Widget callItem(int i, int x) {
    return historyItem[i][x] != 0
        ? Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: Url().ddragon +
                    version +
                    '/img/item/' +
                    historyItem[i][x].toString() +
                    '.png',
                errorWidget: (context, url, error) => Icon(Icons.texture),
                fit: BoxFit.fill,
                width: (MediaQuery.of(context).size.width) / 15,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                width: (MediaQuery.of(context).size.width) / 15,
                height: (MediaQuery.of(context).size.width) / 15,
              ),
            ),
          );
  }

  Widget callAccs(int i) {
    return historyAccs[i] != '0'
        ? Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: Url().ddragon +
                    version +
                    '/img/item/' +
                    historyAccs[i].toString() +
                    '.png',
                errorWidget: (context, url, error) => Icon(Icons.image),
                fit: BoxFit.fill,
                width: (MediaQuery.of(context).size.width) / 15,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                width: (MediaQuery.of(context).size.width) / 15,
                height: (MediaQuery.of(context).size.width) / 15,
              ),
            ),
          );
  }

  Widget loadingAnime() {
    return Expanded(
      child: LiquidLinearProgressIndicator(
          center: Text("게비가 좋아하는 물이 차오릅니다.", style: TextStyle(fontSize: 16)),
          //value: val,
          // borderColor: Colors.yellow[400],
          // borderWidth: 4,
          borderRadius: 20.0,
          direction: Axis.vertical,
          backgroundColor: Colors.white,
          value: 0.8,
          valueColor: new AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(128, 214, 250, 1),
          )),
    );
  }

  Widget searchiing() {
    print('searchiing() start');
    var m = MediaQuery.of(context).size;
    return Card(
        shadowColor: Color.fromRGBO(2, 6, 89, 1),
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow[600], width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(
          (m.width).round() / 50,
          (m.height).round() / 5,
          (m.width).round() / 50,
          (m.height).round() / 200,
        ),
        child: Container(
          width: m.width * 0.9,
          height: m.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: m.height / 7,
                  child: Text(
                    noName,
                    style: TextStyle(
                        fontSize: m.width / 18, fontWeight: FontWeight.bold),
                  )),
              Container(
                  width: m.width * 8,
                  height: m.height / 8,
                  child: Image.asset('images/etc/Crab.v1.gif')),
            ],
          ),
        ));
  }

  Widget loading() {
    _isloading = false;
    var m = MediaQuery.of(context).size;
    return Card(
        shadowColor: Color.fromRGBO(2, 6, 89, 1),
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow[600], width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(
          (m.width).round() / 50,
          (m.height).round() / 5,
          (m.width).round() / 50,
          (m.height).round() / 200,
        ),
        child: Container(
          width: m.width * 0.9,
          height: m.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: m.height / 7,
                  child: Text('로딩중')),
              Container(
                  width: m.width * 8,
                  height: m.height / 8,
                  child: Image.asset('images/etc/Crab.v1.gif')),
              Expanded(
                child: LiquidLinearProgressIndicator(
                    center: Text("게비가 좋아하는 물이 차오릅니다.",
                        style: TextStyle(fontSize: 16)),
                    //value: val,
                    // borderColor: Colors.yellow[400],
                    // borderWidth: 4,
                    borderRadius: 20.0,
                    direction: Axis.vertical,
                    backgroundColor: Colors.white,
                    value: 0.8,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(128, 214, 250, 1),
                    )),
              )
            ],
          ),
        ));
  }

  Widget positionList(Size m) {
    return mainPosition != ''
        ? Card(
            shadowColor: Color.fromRGBO(2, 6, 89, 1),
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellow[600], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round() / 50,
              (MediaQuery.of(context).size.height).round() / 50,
              (MediaQuery.of(context).size.width).round() / 50,
              (MediaQuery.of(context).size.height).round() / 200,
            ),
            child: Wrap(direction: Axis.vertical, children: <Widget>[
              Container(
                  margin: EdgeInsets.all(m.width / 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                '메인 포지션',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: m.width / 30),
                              ),
                              mainPosition != 'NONE'
                                  ? Image.asset(
                                      'images/api_source/ranked-positions/' +
                                          mainPosition +
                                          '.png',
                                      width: m.width / 9,
                                      height: m.width / 9,
                                    )
                                  : Container(),
                            ],
                          ),
                          Container(
                            width: m.width / 50,
                          ),
                          Column(
                            children: <Widget>[
                              Text('서브 포지션',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: m.width / 30)),
                              subPosition != 'NONE'
                                  ? Image.asset(
                                      'images/api_source/ranked-positions/' +
                                          subPosition +
                                          '.png',
                                      width: m.width / 9,
                                      height: m.width / 9,
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ))
            ]))
        : Container();
  }

//주 챔피언 목록
  Widget mainChampionList(Size m) {
    print('mainChampionList() start');
    return mainChampionName.isNotEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              mainChampion(m, 0),
              mainChampion(m, 1),
              mainChampion(m, 2)
            ],
          )
        : Container();
  }

//주 챔피언
  Widget mainChampion(Size m, int i) {
    if (j == 5) {
      j = 0;
    }
    if (mainChampionRate[i] == 'None') {
      mainChampionRate[i] = '0%';
    }
    if (mainChampionName[i].isNotEmpty) {
      mainChampionK[i] = mainChampionK[i].split('.')[0];
      mainChampionD[i] = mainChampionD[i].split('.')[0];
      mainChampionA[i] = mainChampionA[i].split('.')[0];
    }
    if (mainChampionKoName[i] == '트위스티드 페이트') {
      mainChampionKoName[i] = '트페';
    }
    if (mainChampionKoName[i] == '누누와 윌럼프') {
      mainChampionKoName[i] = '누누';
    }
    if (mainChampionKoName[i] == '아우렐리온 솔') {
      mainChampionKoName[i] = '아우솔';
    }
    return mainChampionName.isNotEmpty
        ? Card(
            shadowColor: Color.fromRGBO(2, 6, 89, 1),
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellow[600], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round() / 50,
              (MediaQuery.of(context).size.height).round() * 0.005,
              (MediaQuery.of(context).size.width).round() / 50,
              0,
            ),
            child: Wrap(direction: Axis.vertical, children: <Widget>[
              Container(
                  margin: EdgeInsets.all(m.width / 20),
                  child: Column(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: 'http://ddragon.leagueoflegends.com/cdn/' +
                            version +
                            '/img/champion/' +
                            mainChampionName[i] +
                            '.png',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromRGBO(242, 242, 242, 1),
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(242, 226, 5, 1))),
                        errorWidget: (context, url, error) => Icon(Icons.image),
                        fit: BoxFit.fill,
                        width: (MediaQuery.of(context).size.width) / 7,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0, m.width / 40, 0, m.width / 40),
                        child: Text(
                          mainChampionKoName[i] /* .replaceAll(' ', '\n   ') */,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: m.width / 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(mainChampionWin[i] + '승 ',
                              style: TextStyle(
                                  color: Colors.blue, fontSize: m.width / 30)),
                          Text(mainChampionLose[i] + '패',
                              style: TextStyle(
                                  color: Colors.red, fontSize: m.width / 30)),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, m.width / 40, 0, 0),
                        child: Text('승률 : ' + mainChampionRate[i],
                            style: TextStyle(
                                color: Colors.black, fontSize: m.width / 30)),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, m.width / 40, 0, 0),
                        child: Text(
                            mainChampionK[i] +
                                '/' +
                                mainChampionD[i] +
                                '/' +
                                mainChampionA[i],
                            style: TextStyle(
                                color: Colors.black, fontSize: m.width / 30)),
                      ),
                    ],
                  ))
            ]))
        : Container();
  }

  //평균 KDA
  Widget avgKDA(Size m) {
    return avgKills != ''
        ? Card(
            shadowColor: Color.fromRGBO(2, 6, 89, 1),
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellow[600], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round() / 25,
              (MediaQuery.of(context).size.height).round() / 50,
              (MediaQuery.of(context).size.width).round() / 50,
              (MediaQuery.of(context).size.height).round() / 200,
            ),
            child: Wrap(direction: Axis.vertical, children: <Widget>[
              Container(
                  margin: EdgeInsets.all(m.width / 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('평균 ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: m.width / 20)),
                          Text(
                            'K',
                            style: TextStyle(
                                color: Colors.black, fontSize: m.width / 20),
                          ),
                          Text('D',
                              style: TextStyle(
                                  color: Colors.black, fontSize: m.width / 20)),
                          Text('A',
                              style: TextStyle(
                                  color: Colors.black, fontSize: m.width / 20))
                        ],
                      ),
                      Container(
                        height: m.width / 30,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            avgKills,
                            style: TextStyle(
                                color: Colors.blue, fontSize: m.width / 30),
                          ),
                          Text('/',
                              style: TextStyle(
                                  color: Colors.black, fontSize: m.width / 30)),
                          Text(avgDeaths,
                              style: TextStyle(
                                  color: Colors.red, fontSize: m.width / 30)),
                          Text('/',
                              style: TextStyle(
                                  color: Colors.black, fontSize: m.width / 30)),
                          Text(avgAssists,
                              style: TextStyle(
                                  color: Colors.black, fontSize: m.width / 30))
                        ],
                      ),
                    ],
                  ))
            ]))
        : Container();
  }

  //아이콘 + 티어
  Widget iconAndTier(Size m) {
    return Container(
      child: summonerIcon(version),
    );
  }

//솔로 티어정보 + 이미지
  Widget soloTierInfo(Size m) {
    var soloEmblems = tierSolo.split(' ');
    return tierSolo != ''
        ? tierSolo == 'Unranked'
            ? Text('Unranked')
            : Container(
                child: Column(
                children: <Widget>[
                  Text(
                    '솔로 랭크',
                    style: TextStyle(
                        fontSize: m.width / 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(2, 6, 89, 1)),
                  ),
                  Image.asset(
                    'images/api_source/emblems/' + soloEmblems[0] + '.png',
                    width: m.width / 5,
                    height: m.width / 5,
                  ),
                  Text(
                    tierSolo,
                    style: TextStyle(
                        fontSize: m.width / 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(2, 6, 89, 1)),
                  ),
                ],
              ))
        : Text('');
  }

//자유 티어정보 + 이미지
  Widget flexTierInfo(Size m) {
    var flexEmblems = tierFlex.split(' ');
    return tierFlex != ''
        ? tierFlex == 'Unranked'
            ? Text('Unranked')
            : Container(
                child: Column(
                children: <Widget>[
                  Text(
                    '자유 랭크',
                    style: TextStyle(
                        fontSize: m.width / 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(2, 6, 89, 1)),
                  ),
                  Image.asset(
                    'images/api_source/emblems/' + flexEmblems[0] + '.png',
                    width: m.width / 5,
                    height: m.width / 5,
                  ),
                  Text(
                    tierFlex,
                    style: TextStyle(
                        fontSize: m.width / 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(2, 6, 89, 1)),
                  ),
                ],
              ))
        : Text('');
  }

//솔로+자유
  Widget tierInfo(Size m) {
    return tierFlex != ''
        ? Row(children: <Widget>[
            soloTierInfo(m),
            Container(
              width: m.width / 20,
            ),
            flexTierInfo(m)
          ])
        : Container();
  }

//소환사 아이콘
  Widget summonerIcon(String version) {
    var m = MediaQuery.of(context).size;
    return getIcon != ''
        ? Card(
            shadowColor: Color.fromRGBO(2, 6, 89, 1),
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellow[600], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round() / 25,
              0,
              (MediaQuery.of(context).size.width).round() / 50,
              (MediaQuery.of(context).size.height).round() / 200,
            ),
            child: Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(m.width / 30),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(m.width / 30),
                                  child: Container(
                                      padding: EdgeInsets.all(m.width / 160),
                                      color: Colors.black,
                                      child: tierFlex != ''
                                          ? CachedNetworkImage(
                                              imageUrl: Url().ddragon +
                                                  version +
                                                  '/img/profileicon/' +
                                                  getIcon +
                                                  '.png',
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              242, 242, 242, 1),
                                                      valueColor:
                                                          new AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Color.fromRGBO(
                                                                  242,
                                                                  226,
                                                                  5,
                                                                  1))),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.image),
                                              fit: BoxFit.fill,
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  5,
                                            )
                                          : Image.asset('')),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(2, 6, 89, 1),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: m.width / 160),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        m.width / 80,
                                        m.width / 160,
                                        m.width / 80,
                                        m.width / 160),
                                    child: Text(
                                      getLevel,
                                      style: TextStyle(
                                          color: Color.fromRGBO(242, 226, 5, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: m.width / 30),
                                    ))
                              ],
                            ),
                            Container(
                              child: Text(
                                getName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: m.width / 20,
                                  color: Color.fromRGBO(2, 6, 89, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(width: m.width / 15),
                        tierInfo(m)
                      ],
                    )),
              ],
            ))
        : Text('이미지!!!');
  }

//검색
  Widget textinput(String name) {
    print('textinput() start');

    var m = MediaQuery.of(context).size;

    return tbc == 0
        ? Card(
            shadowColor: Color.fromRGBO(2, 6, 89, 1),
            //elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellow[600], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round() / 25,
              (MediaQuery.of(context).size.height).round() / 50,
              (MediaQuery.of(context).size.width).round() / 50,
              (MediaQuery.of(context).size.height).round() / 200,
            ),
            child: Container(
                alignment: Alignment.center,
                width: m.width * 0.75,
                child: TextField(
                  controller: myController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.yellow[600],
                    ),
                    hintText: '소환사명 검색',
                    hintStyle: TextStyle(color: Colors.grey),
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    //   borderSide:
                    //       BorderSide(color: Colors.yellow[600], width: 2),
                    // ),
                  ),
                  onSubmitted: (text) {
                    setState(() {
                      print(
                          '#############################################################2');
                      tierFlex = '';
                      a = myController.text;
                      tbc = 1;
                      myController.text = null;
                      champ(a);
                      //summonerMatchHistory(a);
                    });
                  },
                )))
        : loading();
    // Container(
    //     width: m.width* 0.85,
    //     height: m.width / 5,
    //     margin: EdgeInsets.fromLTRB(0, m.width / 18, 0,
    //         m.width / 18),
    //     //padding: EdgeInsets.fromLTRB(0, m.width / 1, 0, m.width / 1),
    //     // child: LiquidLinearProgressIndicator(
    //     //     //value: val,
    //     //     // borderColor: Colors.yellow[400],
    //     //     // borderWidth: 4,
    //     //     borderRadius: 20.0,
    //     //     direction: Axis.vertical,
    //     //     backgroundColor: Colors.grey[200],
    //     //     value: 0.5,
    //     //     valueColor: new AlwaysStoppedAnimation<Color>(
    //     //         Color.fromRGBO(128, 214, 250, 1))),
    //   );
  }

//탭바
  Widget tabbar() {
    return Container(
      child: TabBar(
          unselectedLabelColor: Color.fromRGBO(13, 13, 13, 0.5),
          labelColor: Color.fromRGBO(2, 6, 89, 1),
          tabs: [
            Tab(text: '소환사 정보'),
            Tab(text: '포지션별 승률'),
            Tab(text: '챔피언별 승률'),
          ],
          controller: _tabController,
          indicatorColor: Color.fromRGBO(2, 6, 89, 1),
          indicatorSize: TabBarIndicatorSize.tab),
    );
  }

//탭바뷰
  Widget tabbarView() {
    return Expanded(
        child: Container(
      //height: m.height * 0.75,
      child: TabBarView(
        children: <Widget>[
          summonerIcon(version),
          summonerIcon(version),
          summonerIcon(version),
        ],
        controller: _tabController,
      ),
    ));
  }

  bool champState = false;

  champ(String summonerName) async {
    print('champ start');
    loadingState = false;
    _isloading = false;
    http.Response response;
    if (summonerName != '') {
      summonerName = summonerName.replaceAll(' ', '%20');
      try {
        response = await http
            .get(KeyPlus().urlkeyPlusSub(Url().summonerName + summonerName));
        String body = '';
        if (response.statusCode == 200) {
          body = utf8.decode(response.bodyBytes);
          var jsonData = json.decode(body);
          if (jsonData['code'] == 'error') {
            if (mounted) {
              setState(() {
                print(
                    '#############################################################3');
                print('re');
                tbc = 0;
                _isloading = true;
              });
            }
          } else {
            if (mounted) {
              getName = jsonData['summonerName'];
              getIcon = jsonData['profileIconId'].toString();
              getLevel = jsonData['summonerLevel'].toString();
              print('소환사 이름 =' + jsonData['summonerName'].toString());
              print('소환사 레벨 = ' + jsonData['summonerLevel'].toString());
              champState = true;
              if (champState) {
                summonerMatchHistory(summonerName);
                champState = false;
              }
            } else {
              if (mounted) {
                getName = jsonData['code'];
                getIcon = jsonData['code'];
                getLevel = jsonData['code'];
              }
            }
          }
        } else {
          print('Fail');
        }
      } catch (e) {
        print('champ error = $e');
      }
    } else {
      if (mounted) {
        setState(() {
          print(
              '#############################################################4');
          print('re');
          tbc = 0;
          _isloading = true;
        });
      }
    }
  }

  bool summonerMatchHistoryState = false;

  summonerMatchHistory(String summonerName) async {
    print('summonerMatchHistory() start');
    summonerName = summonerName.replaceAll(' ', '%20');

    try {
      http.Response response = await http.get(
          KeyPlus().urlkeyPlusSub(Url().summonerMatchHistory + summonerName));
      String body = '';
      if (response.statusCode == 200) {
        body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);
        if (jsonData['code'] == 'error') {
          if (mounted) {
            setState(() {
              print(
                  '#############################################################5');
              print('re');
              _isloading = true;
              tbc = 0;
              noName = '소환사를 검색해 주세요';
            });
          }
        } else {
          if (mounted) {
            tierSolo = jsonData['tierSolo'];
            tierFlex = jsonData['tierFlex'];

            allWinRateWin = jsonData['allWinRate']['win'].toString();
            allWinRateLose = jsonData['allWinRate']['lose'].toString();
            allWinRateRate = jsonData['allWinRate']['rate'].toString();

            if (jsonData['soloWinRate'] == 'Unranked') {
              soloWinRateWin = 'Unranked';
              soloWinRateLose = 'Unranked';
              soloWinRateRate = 'Unranked';
            } else {
              soloWinRateWin = jsonData['soloWinRate']['win'].toString();
              soloWinRateLose = jsonData['soloWinRate']['lose'].toString();
              soloWinRateRate = jsonData['soloWinRate']['rate'].toString();
            }
            if (jsonData['flexWinRate'] == 'Unranked') {
              flexWinRateWin = 'Unranked';
              flexWinRateLose = 'Unranked';
              flexWinRateRate = 'Unranked';
            } else {
              flexWinRateWin = jsonData['flexWinRate']['win'].toString();
              flexWinRateLose = jsonData['flexWinRate']['lose'].toString();
              flexWinRateRate = jsonData['flexWinRate']['rate'].toString();
            }

            avgKills = jsonData['avgAssists'].toString();
            avgDeaths = jsonData['avgDeaths'].toString();
            avgAssists = jsonData['avgAssists'].toString();

            mainPosition = jsonData['mainPosition'];
            subPosition = jsonData['subPosition'];

            mainChampionLength = jsonData['mainChampion'].length;
            mainChampionName = List<String>(mainChampionLength);
            mainChampionKoName = List<String>(mainChampionLength);

            mainChampionWin = List<String>(mainChampionLength);
            mainChampionLose = List<String>(mainChampionLength);
            mainChampionRate = List<String>(mainChampionLength);
            mainChampionK = List<String>(mainChampionLength);
            mainChampionD = List<String>(mainChampionLength);
            mainChampionA = List<String>(mainChampionLength);

            for (int i = 0; i < mainChampionLength; i++) {
              mainChampionName[i] = jsonData['mainChampion'][i]['name'];
              mainChampionKoName[i] = jsonData['mainChampion'][i]['koName'];
              mainChampionWin[i] =
                  jsonData['mainChampion'][i]['winRate']['win'].toString();
              mainChampionLose[i] =
                  jsonData['mainChampion'][i]['winRate']['lose'].toString();
              mainChampionRate[i] =
                  jsonData['mainChampion'][i]['winRate']['rate'].toString();
              mainChampionK[i] =
                  jsonData['mainChampion'][i]['avgKills'].toString();
              mainChampionD[i] =
                  jsonData['mainChampion'][i]['avgDeaths'].toString();
              mainChampionA[i] =
                  jsonData['mainChampion'][i]['avgAssists'].toString();
            }

            historyLength = jsonData['history'].length;
            historyQT = List<String>(historyLength);
            historyWin = List<String>(historyLength);
            historyChamp = List<String>(historyLength);
            historyKoChamp = List<String>(historyLength);
            historyK = List<String>(historyLength);
            historyD = List<String>(historyLength);
            historyA = List<String>(historyLength);
            historyCS = List<String>(historyLength);
            historyGC = List<String>(historyLength);
            historyGD = List<String>(historyLength);
            historyRuneA = List<String>(historyLength);
            historyRuneB = List<String>(historyLength);
            historySpellA = List<String>(historyLength);
            historySpellB = List<String>(historyLength);
            historyItem = List<List>(historyLength);
            historyAccs = List<String>(historyLength);
            gameId = List<int>(historyLength);
            for (int i = 0; i < historyLength; i++) {
              historyQT[i] = jsonData['history'][i]['queueType'];
              historyWin[i] = jsonData['history'][i]['win'].toString();
              historyChamp[i] = jsonData['history'][i]['champion'];
              historyKoChamp[i] = jsonData['history'][i]['koChampion'];
              if (historyKoChamp[i] == '트위스티드 페이트') {
                historyKoChamp[i] = '트페';
              }
              historyK[i] = jsonData['history'][i]['kills'].toString();
              historyD[i] = jsonData['history'][i]['deaths'].toString();
              historyA[i] = jsonData['history'][i]['assists'].toString();
              historyCS[i] = jsonData['history'][i]['cs'].toString();
              historyGC[i] = jsonData['history'][i]['gameCreation'];
              historyGD[i] = jsonData['history'][i]['gameDuration'];
              historyRuneA[i] = jsonData['history'][i]['runeA'].toString();
              historyRuneB[i] = jsonData['history'][i]['runeB'].toString();
              historySpellA[i] = jsonData['history'][i]['spellA'].toString();
              historySpellB[i] = jsonData['history'][i]['spellB'].toString();
              historyItem[i] = jsonData['history'][i]['item'];
              historyAccs[i] = jsonData['history'][i]['accs'].toString();
              gameId[i] = jsonData['history'][i]['gameId'];
            }
            summonerMatchHistoryState = true;
            if (summonerMatchHistoryState) {
              champitemUrl();
              summonerMatchHistoryState = false;
            }
          }
        }
      } else {
        print('Failed to load post');
        setState(() {
          print(
              '#############################################################6');
          tbc = 0;
          _isloading = true;
        });
      }
    } catch (e) {
      print('summonerMatchHistory error = $e');
      setState(() {
        print('#############################################################7');
        tbc = 0;
        _isloading = true;
      });
    }
  }

  fetchVersion() async {
    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    try {
      http.Response response = await http.get(Url().version);
      String body = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(body);
        if (mounted) {
          setState(() {
            print(
                '#############################################################8');
            version = jsonData[0];
            summonerIcon(version);
            tierFlex = '';
            a = myController.text;
            tbc = 1;
            myController.text = null;
            champ(providerSummonerName.summerName);
          });
        }
      } else {
        print('Failed to load post');
        fetchVersion();
      }
    } on Exception catch (_) {
      print('response error');
      fetchVersion();
    }
  }

  bool champitemUrlState = false;
  champitemUrl() async {
    try {
      final response =
          await http.get(Url().ddragon + version + '/data/ko_KR/item.json');
      print(Url().ddragon + version + '/data/ko_KR/item.json');
      String body = '';
      if (response.statusCode == 200) {
        body = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(body);
        String x = '';
        if (mounted) {
          historyItemKo = List<List>(historyLength);
          for (int i = 0; i < historyItem.length; i++) {
            for (int j = 0; j < historyItem[i].length; j++) {
              if (historyItem[i][j] != 0) {
                if (jsonData['data'][historyItem[i][j].toString()] != null) {
                  x = x +
                      (jsonData['data'][historyItem[i][j].toString()]['name']) +
                      '/';
                } else {
                  x = x + '0/';
                }
              } else {
                print('0');
                x = x + '0/';
              }
            }
            historyItemKo[i] = x.split('/');
            historyItemKo[i] = x.split('/');
            historyItemKo[i].removeAt(6);
            x = '';
          }
          print('historyItemKo = $historyItemKo.toString()');
          champitemUrlState = true;
          if (champitemUrlState) {
            runesInfo();
            champitemUrlState = false;
          }
          if (getName == null) {
            getName = '검색중';

            getIcon = '';
            getLevel = '';
          }
        }
      } else {
        print('champitemUrl() Error!');
      }
    } catch (e) {
      print('champitemUrl error = $e');
    }
  }

  runesInfo() async {
    final response = await http
        .get(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
    String body = utf8.decode(response.bodyBytes);

    var jsonData = json.decode(body);
    if (mounted) {
      historyRuneAIcon = List<String>(historyLength);
      for (var i = 0; i < historyLength; i++) {
        for (var j = 0; j < jsonData.length; j++) {
          if (historyRuneA[i] == jsonData[j]['id'].toString()) {
            historyRuneAIcon[i] = jsonData[j]['icon'];
          }
        }
      }
      historyRuneBIcon = List<String>(historyLength);
      for (var i = 0; i < historyLength; i++) {
        for (var j = 0; j < jsonData.length; j++) {
          if (historyRuneB[i] == jsonData[j]['id'].toString()) {
            historyRuneBIcon[i] = jsonData[j]['icon'];
          }
        }
      }
      setState(() {
        print('#############################################################9');
        tbc = 0;
        loadingState = true;
      });
    }
  }

  Widget chsName() {
    bool _value = true;
    return Container(
        margin: EdgeInsets.fromLTRB(
          (MediaQuery.of(context).size.width).round() / 10,
          (MediaQuery.of(context).size.height).round() / 10,
          (MediaQuery.of(context).size.width).round() / 10,
          (MediaQuery.of(context).size.height).round() / 200,
        ),
        width: (MediaQuery.of(context).size.width).round() / 2,
        height: (MediaQuery.of(context).size.width).round() / 1.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
          border: Border.all(color: Colors.blue[400], width: 1),
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: CheckboxListTile(
                  title: Text('왼손이 흐겸룡'),
                  value: _value,
                  onChanged: (bool value) {
                    print('왼손흑화');
                  }),
            ),
            Container(
              child: CheckboxListTile(
                  title: Text('제기랄머해'),
                  value: _value,
                  onChanged: (bool value) {
                    print('젝일');
                  }),
            ),
            Container(
              child: CheckboxListTile(
                  title: Text('시노등칙힌'),
                  activeColor: Colors.blue[600],
                  checkColor: Colors.yellow[600],
                  value: _value,
                  onChanged: (bool value) {
                    print('치킨은 못참지');
                  }),
            ),
            Container(
                child: Divider(
              color: Colors.blue[400],
              height: 10,
              thickness: 2,
              indent: 40,
              endIndent: 40,
            )),
            Row(
              children: <Widget>[
                Container(
                  child: FloatingActionButton(
                    elevation: 4.0,
                    backgroundColor: Colors.white,
                    mini: true,
                    onPressed: () {
                      print('소환사 추가');
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.blue[400],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        side:
                            BorderSide(color: Colors.yellow[400], width: 3.0)),
                  ),
                ),
                Container(
                  child: FloatingActionButton(
                    elevation: 4.0,
                    backgroundColor: Colors.white,
                    mini: true,
                    onPressed: () {
                      print('소환사 삭제');
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.blue[400],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        side:
                            BorderSide(color: Colors.yellow[400], width: 3.0)),
                  ),
                ),
                Container(
                  child: FloatingActionButton(
                    elevation: 4.0,
                    backgroundColor: Colors.white,
                    mini: true,
                    onPressed: () {
                      print('로그아웃');
                    },
                    child: Icon(
                      WebSymbols.logout,
                      color: Colors.blue[400],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        side:
                            BorderSide(color: Colors.yellow[400], width: 3.0)),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget myRnk() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 10,
        (MediaQuery.of(context).size.width).round() / 10,
        (MediaQuery.of(context).size.height).round() / 200,
      ),
      width: (MediaQuery.of(context).size.width).round() / 7,
      height: (MediaQuery.of(context).size.width).round() / 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.blue[400], width: 1),
      ),
    );
  }

  Widget refreshBtn() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 200,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 200,
      ),
      child: FloatingActionButton(
        elevation: 4.0,
        backgroundColor: Colors.white,
        mini: true,
        onPressed: () {
          print('새로고침');
        },
        child: Icon(
          Icons.refresh,
          color: Colors.blue[400],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            side: BorderSide(color: Colors.yellow[400], width: 3.0)),
      ),
    );
  }

  Widget refeshNschIcon() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: _animation.value,
          child: Container(
              margin: EdgeInsets.fromLTRB(
                (MediaQuery.of(context).size.width).round() / 6,
                (MediaQuery.of(context).size.height).round() / 100,
                (MediaQuery.of(context).size.width).round() / 200,
                (MediaQuery.of(context).size.height).round() / 100,
              ),
              child: refreshBtn()),
        ),
        Expanded(
          flex: 100,
          child: Container(
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round() / 200,
              (MediaQuery.of(context).size.height).round() / 50,
              (MediaQuery.of(context).size.width).round() / 10,
              (MediaQuery.of(context).size.height).round() / 100,
            ),
            width: 50.0,
            height: 50.0,
            child: FloatingActionButton(
              elevation: 4.0,
              backgroundColor: Colors.white,
              mini: true,
              onPressed: () {
                if (_animationController.value == 0.0) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              },
              child: Icon(
                Linecons.search,
                color: Colors.blue[400],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  side: BorderSide(color: Colors.yellow[400], width: 2.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget smmnSchBtn() {
    return Container();
  }
}

// Url().ddragon + '/img/profileicon/' + getIcon + '.png'
