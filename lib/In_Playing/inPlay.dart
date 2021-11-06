import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import '../Url_List.dart';

startget() {
  InplayState().startGetData();
}

class MyUtility {
  BuildContext context;
  MyUtility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Inplay(),
    );
  }
}

class Inplay extends StatefulWidget {
  @override
  InplayState createState() => InplayState();
}

class InplayState extends State<Inplay> {
  // A => team : 100   B=> team : 200
  List<dynamic> totalA = new List.generate(5, (i) => new List(13));
  List<dynamic> totalB = new List.generate(5, (i) => new List(13));
  // AA => totalArunA num to linkString
  List<String> runImageAA = [];
  // AA => totalArunA_1 num to linkString
  List<String> runImageAAA = [];
  // AB => totalArunB num to linkString
  List<String> runImageAB = [];
  // BA => totalBrunA num to linkString
  List<String> runImageBA = [];
  // BA => totalBrunA_1 num to linkString
  List<String> runImageBAA = [];
  // BB => totalBrunB num to linkString
  List<String> runImageBB = [];
  bool _isLoaded = false;
  bool _loading = false;
  // http://www.gaap.gg:8000/gameStart/  포지션 순서
  List<String> position = ['TOP', 'JUNGLE', 'MID', 'BOTTOM', 'SUPPORT'];

  String summonerName = '';

  String loadingState = '소환사를 검색해 주세요';

  final textController = TextEditingController();

  final _pageController = PageController();

  final _scrollControllerGroup = LinkedScrollControllerGroup();
  ScrollController _scrollController1;
  ScrollController _scrollController2;
  bool cnt = false;
  int length = 0;

  List<String> list = [];

  String version = '';

  bool recommendGameState = true;

  @override
  void initState() {
    fetchVersion();
    recommendGame();
    super.initState();
    _scrollController1 = _scrollControllerGroup.addAndGet();
    _scrollController2 = _scrollControllerGroup.addAndGet();
  }

  startGetData() {
    cnt = true;
    getData();
  }

  @override
  void dispose() {
    textController.dispose();
    _pageController.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  Future getData() async {
    setState(() {
      cnt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 3), () {});
    print('---------------INPLAY START---------------');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        //physics: new NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(height: m.height / 20),
            _isLoaded
                ? totalView()
                : /*  Container(
                    height: m.height / 5,
                    alignment: Alignment.center,
                    child: Text(loadingState),
                  ) */
                !_loading ? Container() : loading(),
            Container(height: m.height / 40),
            textinput(),
            Container(height: m.height / 40),
            !_loading ? matchList() : Container(),
          ],
        ),
      ),
    );
  }

  Widget loading() {
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
          (m.height).round() / 200,
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
                    loadingState,
                    style: TextStyle(
                        fontSize: m.width / 18, fontWeight: FontWeight.bold),
                  )),
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

  Widget matchList() {
    var m = MyUtility(context);
    return Card(
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
      child: Stack(
        children: <Widget>[
          Container(
            width: m.width * 0.7,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, m.height * 0.02, 0, m.height * 0.01),
                  child: Text(
                    '현제 게임중인 소환사',
                    style: TextStyle(
                        fontSize: m.height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: m.height * 0.3,
                  width: m.width * 0.7,
                  child: ListView(
                      physics: new NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        for (int i = 0; i < length; i++)
                          InkWell(
                            child: ClipOval(
                                child: Container(
                              color: Colors.yellow[100],
                              margin: EdgeInsets.fromLTRB(
                                  m.width * 0.12,
                                  m.height * 0.01,
                                  m.width * 0.12,
                                  m.height * 0.01),
                              padding: EdgeInsets.fromLTRB(
                                  0, m.height * 0.005, 0, m.height * 0.005),
                              alignment: Alignment.center,
                              child: Text(list[i]),
                            )),
                            onTap: () {
                              setState(() {
                                _isLoaded = false;
                                gameStart(list[i]);
                              });
                            },
                          ),
                      ]),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              elevation: 4.0,
              backgroundColor: Colors.white,
              mini: true,
              onPressed: () {
                print('새로고침');
                recommendGame();
              },
              child: Icon(
                Icons.refresh,
                color: Colors.blue[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget totalView() {
    var m = MediaQuery.of(context).size;

    return Container(
      height: m.height * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[aTeam(), bTeam()],
      ),
    );
  }

  //aTeamColumn
  Widget aTeam() {
    var m = MediaQuery.of(context).size;
    return Container(
      color: Colors.blue[50],
      width: m.width / 2,
      height: m.height / 1.5,
      child: Column(
        children: <Widget>[
          blueTop(),
          for (int i = 0; i < 5; i++) aTeamInfo(i),
        ],
      ),
    );
  }

  //aTeamColumn top
  Widget blueTop() {
    var m = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, m.width / 40, 0),
            color: Colors.blue[600],
            width: m.width / 40,
            child: Text(
              '',
              style: TextStyle(fontSize: m.width / 15),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '블루팀',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  //aTeamColumn -> info
  Widget aTeamInfo(int i) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                aTeamInfoChamp(i),
                aTeamInfoSpell(i),
                aTeamInfoRune(i),
                aTeamInfoKDA(i),
              ],
            ),
            aTeaminfoNameTier(i),
          ],
        ));
  }

  //aTeamColumn -> ChampImg
  Widget aTeamInfoChamp(int i) {
    var m = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      color: Colors.blue,
      height: m.height * 0.08,
      child: CachedNetworkImage(
        imageUrl:
            Url().ddragon + version + '/img/champion/' + totalA[i][6] + '.png',
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }

  //aTeamColumn -> Spell
  Widget aTeamInfoSpell(int i) {
    var m = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          height: m.height * 0.03,
          child: CachedNetworkImage(
            imageUrl:
                Url().ddragon + version + '/img/spell/' + totalA[i][8] + '.png',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: m.height * 0.03,
          child: CachedNetworkImage(
            imageUrl:
                Url().ddragon + version + '/img/spell/' + totalA[i][9] + '.png',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  //aTeamColumn -> Rune
  Widget aTeamInfoRune(int i) {
    var m = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 50, 0, m.width / 50, 0),
      child: Column(
        children: <Widget>[
          Container(
            height: m.height * 0.03,
            child: CachedNetworkImage(
              imageUrl: Url().ddragon + 'img/' + runImageAAA[i],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: m.height * 0.03,
            child: CachedNetworkImage(
              imageUrl: Url().ddragon + 'img/' + runImageAB[i],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  //aTeamColumn -> KDA
  Widget aTeamInfoKDA(int i) {
    var m = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'KDA' +
                ((double.parse(totalA[i][1]) + double.parse(totalA[i][3])) /
                        double.parse(totalA[i][2]))
                    .toStringAsFixed(1),
            style: TextStyle(fontSize: m.height / 70),
          ),
          Text(
            totalA[i][1] + '/' + totalA[i][2] + '/' + totalA[i][3],
            style: TextStyle(fontSize: m.height / 70),
          ),
        ],
      ),
    );
  }

  //aTeamColumn -> Name + Tier
  Widget aTeaminfoNameTier(int i) {
    var m = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, m.width / 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              totalA[i][0],
              style: TextStyle(
                  fontSize: m.height / 60, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            totalA[i][4],
            style: TextStyle(fontSize: m.height / 90),
          ),
        ],
      ),
    );
  }

  //bTeamColumn
  Widget bTeam() {
    var m = MediaQuery.of(context).size;

    return Container(
      color: Colors.red[50],
      width: m.width / 2,
      height: m.height / 1.5,
      child: Column(
        children: <Widget>[
          redTop(),
          for (int i = 0; i < 5; i++) bTeamInfo(i),
        ],
      ),
    );
  }

//bTeamColumn Top
  Widget redTop() {
    var m = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '레드팀',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(m.width / 40, 0, 0, 0),
            color: Colors.red[600],
            width: m.width / 40,
            child: Text(
              '',
              style: TextStyle(fontSize: m.width / 15),
            ),
          ),
        ],
      ),
    );
  }

  //bTeamColumn -> info
  Widget bTeamInfo(int i) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              bTeamInfoKDA(i),
              bTeamInfoRune(i),
              bTeamInfoSpell(i),
              bTeamInfoChamp(i),
            ],
          ),
          bTeaminfoNameTier(i),
        ],
      ),
    );
  }

  //bTeamColumn -> ChampImg
  Widget bTeamInfoChamp(int i) {
    var m = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
      color: Colors.blue,
      height: m.height * 0.08,
      child: CachedNetworkImage(
        imageUrl:
            Url().ddragon + version + '/img/champion/' + totalB[i][6] + '.png',
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }

  //bTeamColumn -> Spell
  Widget bTeamInfoSpell(int i) {
    var m = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: m.height * 0.03,
          child: CachedNetworkImage(
            imageUrl:
                Url().ddragon + version + '/img/spell/' + totalB[i][8] + '.png',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: m.height * 0.03,
          child: CachedNetworkImage(
            imageUrl:
                Url().ddragon + version + '/img/spell/' + totalB[i][9] + '.png',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  //bTeamColumn -> Rune
  Widget bTeamInfoRune(int i) {
    var m = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 50, 0, m.width / 50, 0),
      child: Column(
        children: <Widget>[
          Container(
            height: m.height * 0.03,
            child: CachedNetworkImage(
              imageUrl: Url().ddragon + 'img/' + runImageBAA[i],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: m.height * 0.03,
            child: CachedNetworkImage(
              imageUrl: Url().ddragon + 'img/' + runImageBB[i],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  //bTeamColumn -> KDA
  Widget bTeamInfoKDA(int i) {
    var m = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'KDA' +
                ((double.parse(totalB[i][1]) + double.parse(totalB[i][3])) /
                        double.parse(totalB[i][2]))
                    .toStringAsFixed(1),
            style: TextStyle(fontSize: m.height / 70),
          ),
          Text(
            totalB[i][1] + '/' + totalB[i][2] + '/' + totalB[i][3],
            style: TextStyle(fontSize: m.height / 70),
          ),
        ],
      ),
    );
  }

  //bTeamColumn -> Name + Tier
  Widget bTeaminfoNameTier(int i) {
    var m = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 15, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            totalB[i][4],
            style: TextStyle(fontSize: m.height / 90),
          ),
          Container(
            child: Text(
              totalB[i][0],
              style: TextStyle(
                  fontSize: m.height / 60, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget textinput() {
    var m = MediaQuery.of(context).size;

    return /* _isLoaded
        ? */
        Card(
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
        0,
      ),
      child: Container(
        width: m.width * 0.75,
        child: TextField(
          controller: textController,
          autocorrect: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.yellow[600],
            ),
            hintText: '소환사명 검색',
            hintStyle: TextStyle(color: Colors.grey),
/*                     enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide:
                          BorderSide(color: Colors.yellow[600], width: 2),
                    ), */
          ),
          onSubmitted: (text) {
            setState(
              () {
                loadingState = '검색 중';
                gameStart(textController.text);
                recommendGame();
              },
            );
          },
        ),
      ),
    );
    /*  : Container(
            width: mw,
            height: mw / 15,
            margin: EdgeInsets.fromLTRB(0, mw / 18, 0,
                mw / 18),
            //padding: EdgeInsets.fromLTRB(0, mw / 1, 0, mw / 1),
            child: LinearProgressIndicator(
                //value: val,
                backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(242, 226, 5, 1))),
          ); */
  }

  //Url().gameStrat get
  gameStart(String text) async {
    _loading = true;
    summonerName = text;
    if (summonerName != '') {
      summonerName = summonerName.replaceAll(' ', '%20');
    }
    print(KeyPlus().urlkeyPlusSub(Url().gameStrat + summonerName));
    http.Response response;
    response =
        await http.get(KeyPlus().urlkeyPlusSub(Url().gameStrat + summonerName));
    print((KeyPlus().urlkeyPlusSub(Url().gameStrat + summonerName)));
    String body = '';
    if (response.statusCode == 200) {
      print('after response 200');
      body = utf8.decode(response.bodyBytes);
      var jsonData = json.decode(body);
      if (jsonData['status'] == "Data not found") {
        if (mounted) {
          setState(() {
            textController.text = '';
            loadingState = '게임 중이 아닙니다';
          });
        }
      } else if (jsonData['status'] == "소환사 이름 다시") {
        if (mounted) {
          setState(() {
            textController.text = '';
            loadingState = '소환사 명을 입력해 주세요';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            loadingState = '열심히 가져오는 중...';
            for (int i = 0; i < jsonData["participants"]['100'].length; i++) {
              //summonerName => totalA[i][0]
              totalA[i][0] =
                  jsonData["participants"]['100'][position[i]]['summonerName'];
              //avgKills => totalA[i][1]
              totalA[i][1] = jsonData["participants"]['100'][position[i]]
                      ['avgKills']
                  .toString();
              //avgDeaths => totalA[i][2]
              totalA[i][2] = jsonData["participants"]['100'][position[i]]
                      ['avgDeaths']
                  .toString();
              //avgAssists => totalA[i][3]
              totalA[i][3] = jsonData["participants"]['100'][position[i]]
                      ['avgAssists']
                  .toString();
              //tierSolo => totalA[i][4]
              totalA[i][4] =
                  jsonData["participants"]['100'][position[i]]['tierSolo'];
              //tierFlex => totalA[i][5]
              totalA[i][5] =
                  jsonData["participants"]['100'][position[i]]['tierFlex'];
              //champName => totalA[i][6]
              totalA[i][6] =
                  jsonData["participants"]['100'][position[i]]['champName'];
              //champKoName => totalA[i][7]
              totalA[i][7] =
                  jsonData["participants"]['100'][position[i]]['champKoName'];
              //spellA => totalA[i][8]
              totalA[i][8] =
                  jsonData["participants"]['100'][position[i]]['spellA'];
              //spellB => totalA[i][9]
              totalA[i][9] =
                  jsonData["participants"]['100'][position[i]]['spellB'];
              //mainrunes => totalA[i][10]
              totalA[i][10] = jsonData["participants"]['100'][position[i]]
                      ['runes'][0]["main"][0]
                  .toString();
              //subrunes => totalA[i][11]
              totalA[i][11] = jsonData["participants"]['100'][position[i]]
                      ['runes'][0]["sub"][0]
                  .toString();
              //mainrunes1 => totalB[i][11]
              totalA[i][12] = jsonData["participants"]['100'][position[i]]
                      ['runes'][0]["main"][1]
                  .toString();
            }

            for (int i = 0; i < jsonData["participants"]['200'].length; i++) {
              //summonerName => totalB[i][0]
              totalB[i][0] =
                  jsonData["participants"]['200'][position[i]]['summonerName'];
              //avgKills => totalB[i][1]
              totalB[i][1] = jsonData["participants"]['200'][position[i]]
                      ['avgKills']
                  .toString();
              //avgDeaths => totalB[i][2]
              totalB[i][2] = jsonData["participants"]['200'][position[i]]
                      ['avgDeaths']
                  .toString();
              //avgAssists => totalB[i][3]
              totalB[i][3] = jsonData["participants"]['200'][position[i]]
                      ['avgAssists']
                  .toString();
              //tierSolo => totalB[i][4]
              totalB[i][4] =
                  jsonData["participants"]['200'][position[i]]['tierSolo'];
              //tierFlex => totalB[i][5]
              totalB[i][5] =
                  jsonData["participants"]['200'][position[i]]['tierFlex'];
              //champName => totalB[i][6]
              totalB[i][6] =
                  jsonData["participants"]['200'][position[i]]['champName'];
              //champKoName => totalB[i][7]
              totalB[i][7] =
                  jsonData["participants"]['200'][position[i]]['champKoName'];
              //spellA => totalB[i][8]
              totalB[i][8] =
                  jsonData["participants"]['200'][position[i]]['spellA'];
              //spellB => totalB[i][9]
              totalB[i][9] =
                  jsonData["participants"]['200'][position[i]]['spellB'];
              //mainrunes => totalB[i][10]
              totalB[i][10] = jsonData["participants"]['200'][position[i]]
                      ['runes'][0]["main"][0]
                  .toString();
              //subrunes => totalB[i][11]
              totalB[i][11] = jsonData["participants"]['200'][position[i]]
                      ['runes'][0]["sub"][0]
                  .toString();
              //mainrunes1 => totalB[i][11]
              totalB[i][12] = jsonData["participants"]['200'][position[i]]
                      ['runes'][0]["main"][1]
                  .toString();
            }
            runesInfo();
          });
        } else {
          throw Exception('Fail');
        }
      }
    }
  }

  //Url().ddragon + version + '/data/ko_KR/runesReforged.json' get
  runesInfo() async {
    final response = await http
        .get(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
    print(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
    String body = utf8.decode(response.bodyBytes);

    var jsonData = json.decode(body);
    if (mounted)
      setState(() {
        runImageAA = List<String>(5);
        for (var i = 0; i < 5; i++) {
          for (var j = 0; j < jsonData.length; j++) {
            if (totalA[i][10] == jsonData[j]['id'].toString()) {
              runImageAA[i] = jsonData[j]['icon'];
            }
          }
        }
        runImageAB = List<String>(5);
        for (var i = 0; i < 5; i++) {
          for (var j = 0; j < jsonData.length; j++) {
            if (totalA[i][11] == jsonData[j]['id'].toString()) {
              runImageAB[i] = jsonData[j]['icon'];
            }
          }
        }
        runImageBA = List<String>(5);
        for (var i = 0; i < 5; i++) {
          for (var j = 0; j < jsonData.length; j++) {
            if (totalB[i][10] == jsonData[j]['id'].toString()) {
              runImageBA[i] = jsonData[j]['icon'];
            }
          }
        }
        runImageBB = List<String>(5);
        for (var i = 0; i < 5; i++) {
          for (var j = 0; j < jsonData.length; j++) {
            if (totalB[i][11] == jsonData[j]['id'].toString()) {
              runImageBB[i] = jsonData[j]['icon'];
            }
          }
        }
        runImageAAA = List<String>(5);

        for (int i = 0; i < 5; i++) {
          for (int j = 0; j < jsonData.length; j++) {
            if (totalA[i][10] == jsonData[j]['id'].toString()) {
              for (int k = 0;
                  k < jsonData[j]['slots'][0]['runes'].length;
                  k++) {
                if (totalA[i][12] ==
                    jsonData[j]['slots'][0]['runes'][k]['id'].toString())
                  runImageAAA[i] = jsonData[j]['slots'][0]['runes'][k]['icon'];
              }
            }
          }
        }
        runImageBAA = List<String>(5);
        for (int i = 0; i < 5; i++) {
          for (int j = 0; j < jsonData.length; j++) {
            if (totalB[i][10] == jsonData[j]['id'].toString()) {
              for (int k = 0;
                  k < jsonData[j]['slots'][0]['runes'].length;
                  k++) {
                if (totalB[i][12] ==
                    jsonData[j]['slots'][0]['runes'][k]['id'].toString())
                  runImageBAA[i] = jsonData[j]['slots'][0]['runes'][k]['icon'];
              }
            }
          }
        }
        print(runImageAA[0]);
        _isLoaded = true;
        _loading = false;
      });
  }

  //Url().version
  fetchVersion() async {
    http.Response response = await http.get(Url().version);
    String body = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(body);
      if (mounted) {
        setState(() {
          version = jsonData[0];
        });
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  recommendGame() async {
    try {
      print('recommendGame() start');
      http.Response response;
      response = await http.get(KeyPlus().urlkeyPlus(Url().recommendGame));
      String body = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(body);
        list = new List<String>(jsonData.length);
        for (int i = 0; i < jsonData.length; i++) {
          list[i] = jsonData[i];
          print(list[i]);
        }
      }
      recommendGameState = false;
      if (recommendGameState == false) {}
      length = list.length;
      if (mounted) {
        setState(() {
          print('length = $length');
        });
      }
    } catch (e) {
      print('Failed to load post$e');
    }
  }
}
