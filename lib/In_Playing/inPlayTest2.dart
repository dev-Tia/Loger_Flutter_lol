import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'package:gaap/Url_List.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

class MyUtility {
  BuildContext context;
  MyUtility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListTest(),
    );
  }
}

class ListTest extends StatefulWidget {
  @override
  ListTestState createState() => ListTestState();
}

class ListTestState extends State<ListTest> {
  String version;
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

  List<String> list = [];
  int length = 0;

  bool _isLoaded = false;
  // ignore: unused_field
  bool _loading = false;
  bool _isFirst = true;
  bool recommendGameState = true;

  // http://www.gaap.gg:8000/gameStart/  포지션 순서
  List<String> position = ['TOP', 'JUNGLE', 'MID', 'BOTTOM', 'SUPPORT'];
  String summonerName = '';

  List<int> blueNumber = [1, 2, 3, 4, 5];
  List<int> redNumber = [1, 2, 3, 4, 5];

  String loadingState = '소환사를 검색해 주세요';

  final _nativeAdController = NativeAdmobController();

  final textController = TextEditingController();
  final _pageController = PageController();
  final _scrollControllerGroup = LinkedScrollControllerGroup();
  ScrollController _scrollController1;
  ScrollController _scrollController2;
  ScrollController _scrollController3;

  @override
  void initState() {
    super.initState();
    fetchVersion();
    recommendGame();
    _scrollController1 = _scrollControllerGroup.addAndGet();
    _scrollController2 = _scrollControllerGroup.addAndGet();
    _scrollController3 = _scrollControllerGroup.addAndGet();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();

    super.dispose();
  }

  int test = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              //physics: NeverScrollableScrollPhysics(),
              child: _isLoaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        topline(),
                        ad(),
                        mainStack(),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(
                          top: MyUtility(context).height * 0.024),
                      alignment: Alignment.center,
                      child: loading()),
            ),
            textinput(),
          ],
        ),
      ),
    );
  }

  Widget ad() {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 70,
      //width: 200,
      child: NativeAdmob(
        adUnitID: providerCheckOS.getadUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.banner,
      ),
    );
  }

  Widget mainStack() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _isLoaded
            ? Container(
                width: MyUtility(context).width,
                height: MyUtility(context).height * 0.80,
                /*  margin: EdgeInsets.only(
                          top: MyUtility(context).height * 0.09), */
                //color: Colors.indigo,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //color: Colors.red[100].withOpacity(0.5),
                      width: MyUtility(context).width * 0.5,
                      height: MyUtility(context).height * 0.80,
                      child: blueMain(),
                    ),
                    Container(
                      //color: Colors.blue[100].withOpacity(0.5),
                      width: MyUtility(context).width * 0.5,
                      height: MyUtility(context).height * 0.80,
                      child: redMain(),
                    ),
                  ],
                ),
              )
            : Container(
                height: MyUtility(context).height * 0.8,
              ),
        _isLoaded
            ? Container(
                width: MyUtility(context).width,
                height: MyUtility(context).height * 0.80,
                /*  margin: EdgeInsets.only(
                          top: MyUtility(context).height * 0.09), */
                //color: Colors.indigo,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      //color: Colors.red[100].withOpacity(0.5),
                      width: MyUtility(context).width * 0.5,
                      height: MyUtility(context).height * 0.80,
                      child: ReorderableListView(
                        padding: EdgeInsets.only(bottom: 0),
                        scrollController: _scrollController1,
                        onReorder: blueOnReorder,
                        children: List.generate(
                          redNumber.length,
                          (index) {
                            return blueSub(index);
                          },
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.blue[100].withOpacity(0.5),
                      width: MyUtility(context).width * 0.5,
                      height: MyUtility(context).height * 0.80,
                      child: ReorderableListView(
                        scrollController: _scrollController2,
                        onReorder: redOnReorder,
                        children: List.generate(
                          blueNumber.length,
                          (index) {
                            return redSub(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        //Text(totalA[0].toString()),
      ],
    );
  }

  Widget topline() {
    return Row(
      children: <Widget>[blueTop(), redTop()],
    );
  }

//-------------------------------------------------------------BlueTEAM-------------------------------------------
  void blueOnReorder(int oldIndex, int newIndex) {
    int temp;
    int temp2;

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    print('new = ' + newIndex.toString());
    print('old = ' + oldIndex.toString());
    setState(() {
      //String game = blueNumber[oldIndex];
      temp = blueNumber[oldIndex];
      temp2 = blueNumber[newIndex];

      blueNumber[oldIndex] = temp2;
      blueNumber[newIndex] = temp;

      /* blueNumber.removeAt(oldIndex);
      blueNumber.insert(newIndex, game); */
      print(blueNumber.toString());
    });
  }

  Widget blueMain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: Alignment.centerRight,
            width: (((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) / totalA[blueNumber[i] - 1][2]).toStringAsFixed(1)).toString() == 'NaN'
                ? 0
                : (((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) / totalA[blueNumber[i] - 1][2]).toStringAsFixed(1)).toString() == '0.0'
                    ? 0
                    : totalA[blueNumber[i] - 1][2] != 0
                        ? MyUtility(context).width *
                            ((((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) /
                                        totalA[blueNumber[i] - 1][2]) /
                                    (((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2]) +
                                        ((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) /
                                            totalA[blueNumber[i] - 1][2]))) *
                                0.5)
                        : MyUtility(context).width *
                            (((((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) / 1) * 1.2) /
                                    ((((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) /
                                            totalB[redNumber[i] - 1][2])) +
                                        ((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) / 1) * 1.2)) *
                                0.5),
            height: MyUtility(context).height * 0.02,
            color: Colors.blue.withOpacity(1),
            margin: EdgeInsets.only(top: MyUtility(context).height * 0.1),
            child: Text((((totalA[blueNumber[i] - 1][1] +
                                    totalA[blueNumber[i] - 1][3]) /
                                totalA[blueNumber[i] - 1][2])
                            .toStringAsFixed(1))
                        .toString() ==
                    'NaN'
                ? '0'
                : totalA[blueNumber[i] - 1][2] != 0
                    ? (((totalA[blueNumber[i] - 1][1] +
                                    totalA[blueNumber[i] - 1][3]) /
                                totalA[blueNumber[i] - 1][2])
                            .toStringAsFixed(1))
                        .toString()
                    : ((((totalA[blueNumber[i] - 1][1] +
                                        totalA[blueNumber[i] - 1][3]) /
                                    1) *
                                1.2)
                            .toStringAsFixed(1))
                        .toString()),
          ),
      ],
    );
  }

  Widget blueTop() {
    var m = MediaQuery.of(context).size;
    return Container(
      width: m.width * 0.5,
      height: m.height * 0.05,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
            alignment: Alignment.centerLeft,
            child: Text(
              '블루팀',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget blueSub(int index) {
    return Container(
      key: ValueKey(index),
      width: MyUtility(context).width * 0.5,
      height: MyUtility(context).height * 0.1,
      //color: Colors.red,
      margin: EdgeInsets.only(bottom: MyUtility(context).height * 0.02),
      child: Card(
        color: Colors.blue[100],
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                teamInfoChamp('blue', index),
                teamInfoSpell('blue', index),
                teamInfoRune('blue', index),
                teamInfoKDA('blue', index),
              ],
            ),
            teaminfoNameTier('blue', index),
          ],
        ),
      ),
    );
  }

//-------------------------------------------------------------redTEAM-------------------------------------------
  void redOnReorder(int oldIndex, int newIndex) {
    int temp;
    int temp2;
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
/*       String game = redNumber[oldIndex];
 */
      temp = redNumber[oldIndex];
      temp2 = redNumber[newIndex];

      redNumber[oldIndex] = temp2;
      redNumber[newIndex] = temp;
      /*  redNumber.removeAt(oldIndex);
      redNumber.insert(newIndex, game); */
      print(redNumber.toString());
    });
  }

  Widget redMain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              width: (((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / 1) * 1.2).toStringAsFixed(1) == 'NaN'
                  ? 0
                  : (((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2])).toStringAsFixed(1) == '0.0'
                      ? 0
                      : totalB[redNumber[i] - 1][2] == 0
                          ? MyUtility(context).width *
                              (((((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / 1) * 1.2) /
                                      ((((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2])) +
                                          ((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) / 1) *
                                              1.2)) *
                                  0.5)
                          : MyUtility(context).width *
                              ((((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2]) /
                                      (((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2]) +
                                          ((totalA[blueNumber[i] - 1][1] + totalA[blueNumber[i] - 1][3]) /
                                              totalA[blueNumber[i] - 1][2]))) *
                                  0.5),
              height: MyUtility(context).height * 0.02,
              color: Colors.red.withOpacity(1),
              margin: EdgeInsets.only(top: MyUtility(context).height * 0.1),
              child: Text((((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2]).toStringAsFixed(1) == 'NaN' ? '0' : totalB[redNumber[i] - 1][2] == 0 ? (((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / 1) * 1.2).toStringAsFixed(1) : ((totalB[redNumber[i] - 1][1] + totalB[redNumber[i] - 1][3]) / totalB[redNumber[i] - 1][2]).toStringAsFixed(1)))),
      ],
    );
  }

  Widget redTop() {
    var m = MediaQuery.of(context).size;
    return Container(
      width: m.width * 0.5,
      height: m.height * 0.05,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
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

  Widget redSub(int index) {
    return Container(
      key: ValueKey(index),
      width: MyUtility(context).width * 0.5,
      height: MyUtility(context).height * 0.1,
      //color: Colors.blue,
      margin: EdgeInsets.only(bottom: MyUtility(context).height * 0.02),
      child: Card(
        color: Colors.red[100],
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                teamInfoKDA('red', index),
                teamInfoRune('red', index),
                teamInfoSpell('red', index),
                teamInfoChamp('red', index),
              ],
            ),
            teaminfoNameTier('red', index),
          ],
        ),
      ),
    );
  }
  //------------------------------------------------info--------------------------------------------

  Widget teamInfoChamp(String team, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          MyUtility(context).height * 0.01,
          MyUtility(context).height * 0.01,
          MyUtility(context).height * 0.01,
          MyUtility(context).height * 0.01),
      color: Colors.blue,
      height: MyUtility(context).height * 0.05,
      child: CachedNetworkImage(
        imageUrl: team == 'red'
            ? Url().ddragon +
                version +
                '/img/champion/' +
                totalB[redNumber[index] - 1][6] +
                '.png'
            : Url().ddragon +
                version +
                '/img/champion/' +
                totalA[blueNumber[index] - 1][6] +
                '.png',
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget teamInfoSpell(String team, int index) {
    var m = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: m.height * 0.02,
          child: CachedNetworkImage(
            imageUrl: team == 'red'
                ? Url().ddragon +
                    version +
                    '/img/spell/' +
                    totalB[redNumber[index] - 1][8] +
                    '.png'
                : Url().ddragon +
                    version +
                    '/img/spell/' +
                    totalA[blueNumber[index] - 1][8] +
                    '.png',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: m.height * 0.02,
          child: CachedNetworkImage(
            imageUrl: team == 'red'
                ? Url().ddragon +
                    version +
                    '/img/spell/' +
                    totalB[redNumber[index] - 1][9] +
                    '.png'
                : Url().ddragon +
                    version +
                    '/img/spell/' +
                    totalA[blueNumber[index] - 1][9] +
                    '.png',
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  Widget teamInfoRune(String team, int index) {
    var m = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(m.width / 50, 0, m.width / 50, 0),
      child: Column(
        children: <Widget>[
          Container(
            height: m.height * 0.02,
            child: CachedNetworkImage(
              imageUrl: team == 'red'
                  ? Url().ddragon + 'img/' + runImageBAA[redNumber[index] - 1]
                  : Url().ddragon + 'img/' + runImageAAA[blueNumber[index] - 1],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: m.height * 0.02,
            child: CachedNetworkImage(
              imageUrl: team == 'red'
                  ? Url().ddragon + 'img/' + runImageBB[redNumber[index] - 1]
                  : Url().ddragon + 'img/' + runImageAB[blueNumber[index] - 1],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget teamInfoKDA(String team, int index) {
    var m = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            team == 'red'
                ? totalB[redNumber[index] - 1][2] == 0
                    ? 'KDA' +
                        (((totalB[redNumber[index] - 1][1] + totalB[redNumber[index] - 1][3]) / 1) *
                                1.2)
                            .toStringAsFixed(1)
                    : 'KDA' +
                        ((totalB[redNumber[index] - 1][1] +
                                    totalB[redNumber[index] - 1][3]) /
                                totalB[redNumber[index] - 1][2])
                            .toStringAsFixed(1)
                : totalA[blueNumber[index] - 1][2] == 0
                    ? 'KDA' +
                        (((totalA[blueNumber[index] - 1][1] +
                                        totalA[blueNumber[index] - 1][3]) /
                                    1) *
                                1.2)
                            .toStringAsFixed(1)
                    : 'KDA' +
                        ((totalA[blueNumber[index] - 1][1] +
                                    totalA[blueNumber[index] - 1][3]) /
                                totalA[blueNumber[index] - 1][2])
                            .toStringAsFixed(1),
            style: TextStyle(fontSize: m.height / 70),
          ),
          Text(
            team == 'red'
                ? totalB[redNumber[index] - 1][1].toString() +
                    '/' +
                    totalB[redNumber[index] - 1][2].toString() +
                    '/' +
                    totalB[redNumber[index] - 1][3].toString()
                : totalA[blueNumber[index] - 1][1].toString() +
                    '/' +
                    totalA[blueNumber[index] - 1][2].toString() +
                    '/' +
                    totalA[blueNumber[index] - 1][3].toString(),
            style: TextStyle(fontSize: m.height / 70),
          ),
        ],
      ),
    );
  }

  Widget teaminfoNameTier(String team, int index) {
    var m = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.fromLTRB(0, 0, m.width / 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Text(
              team == 'red'
                  ? totalB[redNumber[index] - 1][4]
                  : totalA[blueNumber[index] - 1][0],
              style: TextStyle(fontSize: m.height / 80),
            ),
          ),
          Text(
            team == 'red'
                ? totalB[redNumber[index] - 1][0]
                : totalA[blueNumber[index] - 1][4],
            style: TextStyle(fontSize: m.height / 90),
          ),
        ],
      ),
    );
  }

  Widget textinput() {
    var m = MediaQuery.of(context).size;
    return Positioned(
      bottom: MyUtility(context).height * 0,
      child: Column(
        children: <Widget>[
          Card(
            shadowColor: Color.fromRGBO(2, 6, 89, 1),
            //elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellow[600], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              alignment: Alignment.center,
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
                ),
                onSubmitted: (text) {
                  setState(
                    () {
                      gameStart(textController.text);
                    },
                  );
                },
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      backgroundColor: Colors.white,
                      titlePadding: EdgeInsets.all(0),
                      title: Container(
                        width: m.width * 0.7,
                        height: m.height * 0.1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.yellow[600],
                        ),
                        child: Text(
                          '게임 중인 소환사 목록',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: m.width * 0.7,
                              //height: m.height * 0.19,
                              padding: EdgeInsets.all(0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    //height: m.height * 0.15,
                                    width: m.width * 0.5,
                                    child: Column(children: <Widget>[
                                      for (int i = 0; i < length; i++)
                                        InkWell(
                                          child: Container(
                                            //color: Colors.yellow[100],
                                            margin: EdgeInsets.only(bottom: 10),
                                            alignment: Alignment.center,
                                            child: Text(
                                              list[i],
                                              style: TextStyle(
                                                  fontSize: m.height * 0.02),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              Navigator.pop(context);
                                              _isLoaded = false;
                                              gameStart(list[i]);
                                            });
                                          },
                                        ),
                                    ]),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                recommendGame();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.yellow[600],
                child: Text('게임 중인 소환사 목록'),
              )),
        ],
      ),
    );
  }

  Widget matchList() {
    var m = MyUtility(context);
    return Card(
      shadowColor: Color.fromRGBO(2, 6, 89, 1),
      //elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.yellow[600], width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: m.width * 0.7,
            height: m.height * 0.19,
            padding: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  /* margin: EdgeInsets.fromLTRB(
                      0, m.height * 0.02, 0, m.height * 0.01), */
                  child: Text(
                    '현제 게임중인 소환사',
                    style: TextStyle(
                        fontSize: m.height * 0.02, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: m.height * 0.15,
                  width: m.width * 0.7,
                  child: Column(children: <Widget>[
                    for (int i = 0; i < length; i++)
                      InkWell(
                        child: Container(
                          color: Colors.yellow[100],
                          /*   margin: EdgeInsets.fromLTRB(
                                  m.width * 0.12,
                                  m.height * 0.01,
                                  m.width * 0.12,
                                  m.height * 0.01), */
                          padding: EdgeInsets.only(bottom: 4),
                          alignment: Alignment.center,
                          child: Text(
                            list[i],
                            style: TextStyle(fontSize: m.height * 0.02),
                          ),
                        ),
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
            bottom: 0,
            right: 0,
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
        (m.height).round() / 5,
        (m.width).round() / 50,
        (m.height).round() / 7,
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
              ),
            ),
            Container(
                width: m.width * 8,
                height: m.height / 8,
                child: Image.asset('images/etc/Crab.v1.gif')),
            _isFirst
                ? Container()
                : Expanded(
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
      ),
    );
  }

  gameStart(String text) async {
    loadingState = '검색 중';
    _loading = true;
    _isLoaded = false;
    _isFirst = false;
    summonerName = text;
    if (summonerName != '') {
      summonerName = summonerName.replaceAll(' ', '%20');
    }
    print(KeyPlus().urlkeyPlusSub(Url().gameStrat + summonerName));
    try {
      http.Response response;
      response = await http
          .get(KeyPlus().urlkeyPlusSub(Url().gameStrat + summonerName));
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
              _isFirst = true;
            });
          }
        } else if (jsonData['status'] == "소환사 이름 다시") {
          if (mounted) {
            setState(() {
              textController.text = '';
              loadingState = '소환사 명을 입력해 주세요';
              _isFirst = true;
            });
          }
        } else {
          if (mounted) {
            loadingState = '매치 정보 가져오는 중...';
            for (int i = 0; i < jsonData["participants"]['100'].length; i++) {
              //summonerName => totalA[i][0]
              totalA[i][0] =
                  jsonData["participants"]['100'][position[i]]['summonerName'];
              //avgKills => totalA[i][1]
              totalA[i][1] =
                  jsonData["participants"]['100'][position[i]]['avgKills'];
              //avgDeaths => totalA[i][2]
              totalA[i][2] =
                  jsonData["participants"]['100'][position[i]]['avgDeaths'];
              //avgAssists => totalA[i][3]
              totalA[i][3] =
                  jsonData["participants"]['100'][position[i]]['avgAssists'];
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
              totalB[i][1] =
                  jsonData["participants"]['200'][position[i]]['avgKills'];
              //avgDeaths => totalB[i][2]
              totalB[i][2] =
                  jsonData["participants"]['200'][position[i]]['avgDeaths'];
              //avgAssists => totalB[i][3]
              totalB[i][3] =
                  jsonData["participants"]['200'][position[i]]['avgAssists'];
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
          } else {
            print('gameStart() Fail');
          }
        }
      }
    } catch (e) {
      print('gameStart() Error = $e');
      Future.delayed(const Duration(seconds: 3), () async {
        gameStart(summonerName);
      });
    }
  }

  //Url().ddragon + version + '/data/ko_KR/runesReforged.json' get
  runesInfo() async {
    loadingState = '상세 정보 가져오는 중...';

    try {
      final response = await http
          .get(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
      print(Url().ddragon + version + '/data/ko_KR/runesReforged.json');
      String body = utf8.decode(response.bodyBytes);

      var jsonData = json.decode(body);
      if (mounted) {
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
        setState(() {
          _isLoaded = true;
          _loading = false;
        });
      }
    } catch (e) {
      print('rune Error  = $e');
      Future.delayed(const Duration(seconds: 3), () async {
        runesInfo();
      });
    }
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
      Future.delayed(const Duration(seconds: 3), () async {
        recommendGame();
      });
    }
  }
}
