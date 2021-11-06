import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:gaap/Providers/BoardProvider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gaap/Url_List.dart';
import 'package:gaap/Board/Board_Write.dart';
import 'package:gaap/Board/Board_Contents.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:gaap/Providers/CheckProvider.dart';

class MyUtility {
  BuildContext context;
  MyUtility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BoardMain(),
    );
  }
}

class BoardMain extends StatefulWidget {
  @override
  BoardMainState createState() => BoardMainState();
}

class BoardMainState extends State<BoardMain>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _nativeAdController = NativeAdmobController();

  //comment를 제외한 나머지 데이터 리스트로 관리
  List<dynamic> boardData;
  List<dynamic> boardSave;

  List<dynamic> boardCommentData;
  String summonerName;
  String title;
  int totalPage;
  int page = 1;
  //String contents;
  ScrollController _scrollController;
  @override
  void initState() {
    board(page);
    _scrollController = new ScrollController(
      initialScrollOffset: 50.0,
      keepScrollOffset: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('--------------BoardMainState----------------');
    final boardProvider = Provider.of<BoardProvider>(context, listen: true);
    print('check = ${boardProvider.boardC}');
    if (boardProvider.boardC) {
      boardProvider.boardCheckF();
      reload(page);
    }

    return Scaffold(
      //appBar: appBar(),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              titleBar(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        boardState
                            ? boardList()
                            : Container(
                                height: MyUtility(context).height * 0.25),
                        ad()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          boardWrite(),
        ],
      ),
    );
  }

  Widget ad() {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 400,
      //width: 200,
      child: NativeAdmob(
        loading: Container(),
        adUnitID: providerCheckOS.getadUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
      ),
    );
  }

  Widget appBar() {
    print('appBar() start');
    return AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          '게시판',
          style: TextStyle(
              color: Color.fromRGBO(217, 165, 102, 0.9),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget titleBar() {
    print('titleBar() start');

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          alignment: Alignment.center,
          color: Color.fromRGBO(2, 6, 89, 0.4),
          width: MyUtility(context).width,
          height: MyUtility(context).height * 0.07,
          child: Text(
            '글 목록',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              //fontSize: MyUtility(context).height * 0.02,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            child: Container(
              height: MyUtility(context).height * 0.07,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, right: 10),
              child: Icon(
                Typicons.cw,
                color: refreshState ? Colors.black : Colors.grey,
                size: MyUtility(context).height * 0.05,
              ),
            ),
            onTap: () => reload(page),
          ),
        ),
        Positioned(
          left: 10,
          child: GestureDetector(
            child: Container(
              height: MyUtility(context).height * 0.07,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 10),
              child: Icon(
                Icons.home,
                color: boardState ? Colors.black : Colors.grey,
                size: MyUtility(context).height * 0.05,
              ),
            ),
            onTap: () {
              setState(() {
                page = 1;
                board(1);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget boardList() {
    print('boardList() start');

    return Column(
      children: <Widget>[
        for (int i = 0; i < boardSave.length; i++) boardListTile(i),
        pageSwitch()
      ],
    );
    /* Container(
      height: MyUtility(context).height * 0.75,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            for (int i = boardData.length - 1; i > -1; i--) boardListTile(i)
          ],
        ).toList(),
      ),
    ); */
  }

  Widget boardListTile(int i) {
    print('boardListTile() start');

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MyUtility(context).width * 0.05,
            MyUtility(context).height * 0.01,
            MyUtility(context).width * 0.05,
            MyUtility(context).height * 0.01),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.blue[50], width: 2),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(bottom: MyUtility(context).height * 0.01),
                  //color: Colors.blue[100],
                  child: Text(
                    boardSave[i][2],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(bottom: MyUtility(context).height * 0.01),
                  //color: Colors.blue[100],
                  child: Text(
                    '  [${boardSave[i][5]}]',
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(boardSave[i][1]),
                  Text(
                    boardSave[i][3].substring(5),
                    style:
                        TextStyle(fontSize: MyUtility(context).height * 0.015),
                  ),
                ],
              ),
            ),
          ],
          /*  leading: Container(
        color: Colors.blue[100],
        alignment: Alignment.center,
        width: MyUtility(context).width * 0.1,
        height: MyUtility(context).height * 0.05,
        child: Text(boardSave[i][0]),
      ), */
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: BoardContents(
                //originId
                boardSave[i][0],
                //originName
                boardSave[i][1],
                //originTitle
                boardSave[i][2],
                //originTime
                boardSave[i][3],
                //originContents
                boardSave[i][4],
                //originImage
                boardSave[i][6],
              ),
            ));
      },
    );
  }

  Widget pageSwitch() {
    print('pageSwitch() start');

    return Container(
      height: MyUtility(context).height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*  for (int i = 1; i <= totalPage; i++) Text(i.toString()), */
          GestureDetector(
            child: Container(
              //margin: EdgeInsets.only(right: MyUtility(context).width * 0.85),
              child: Icon(Typicons.left_open,
                  color: page == 1 ? Colors.grey : Colors.black,
                  size: MyUtility(context).height * 0.05),
            ),
            onTap: () {
              page = page - 1;
              if (page == 0) {
                page = 1;
                setState(() {
                  _toStart();
                });
              } else {
                setState(() {
                  board(page);
                  _toStart();
                });
              }
            },
          ),
          SizedBox(
            width: MyUtility(context).width * 0.1,
          ),
          GestureDetector(
            child: Container(
              //margin: EdgeInsets.only(right: MyUtility(context).width * 0.85),
              child: Icon(Typicons.right_open,
                  color: page == totalPage ? Colors.grey : Colors.black,
                  size: MyUtility(context).height * 0.05),
            ),
            onTap: () {
              page = page + 1;
              if (page > totalPage) {
                page = totalPage;

                setState(() {
                  _toStart();
                });
              } else {
                setState(() {
                  board(page);
                  _toStart();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget boardWrite() {
    print('boardWrite() start');

    return Positioned(
      bottom: MyUtility(context).width / 50,
      right: MyUtility(context).width / 50,
      child: Container(
        height: MyUtility(context).height * 0.1,
        alignment: Alignment.centerRight,
        width: MyUtility(context).width,
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 8),
            color: Colors.blue,
            width: MyUtility(context).width * 0.2,
            height: MyUtility(context).height * 0.05,
            child: Text(
              '글쓰기',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: BoardWrite(page),
              )),
        ),
      ),
    );
  }

  Future<void> reload(int page) {
    refreshState = false;
    if (boardState) {
      //boardState = false;
      return board(page);
    } else {
      return board(page);
    }
  }

  void _toStart() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  bool boardState = false;
  bool refreshState = false;
  Future<void> board(int page) async {
    try {
      final response = await http
          .get(KeyPlus().urlkeyPlusSub(Url().boardData + '?page=$page'));
      String body = '';
      //String x = '';

      if (response.statusCode == 200) {
        body = utf8.decode(response.bodyBytes);
      } else {
        throw Exception('Error!');
      }
      var jsonData = json.decode(body);
      boardData =
          new List.generate(jsonData['board'].length, (i) => new List(7));
      boardSave =
          new List.generate(jsonData['board'].length, (i) => new List(7));
      for (int i = 0; i < jsonData['board'].length; i++) {
        boardData[i][0] = jsonData['board'][i]['originId'].toString();
        boardData[i][1] = jsonData['board'][i]['originName'];
        boardData[i][2] = jsonData['board'][i]['originTitle'];
        boardData[i][2] = ShortString().subStringFunction(boardData[i][2]);
        boardData[i][3] = jsonData['board'][i]['originTime'];
        boardData[i][4] = jsonData['board'][i]['originContents'];
        boardData[i][5] = jsonData['board'][i]['commentCount'];
        boardData[i][6] = jsonData['board'][i]['originImage'].toString();
        totalPage = jsonData['page'];
      }
      boardSave = boardData;
      if (mounted) {
        setState(() {
          boardState = true;
          refreshState = true;
        });
      }
    } catch (e) {
      print('board error = $e');
      Future.delayed(const Duration(seconds: 3), () async {
        board(page);
      });
    }
  }
}
/* 
bool boardDeleteState = false;
Future<void> boardDelete(String deleteId, String deleteName) async {
  print('boardCommentInput() Start');
  try {
    String url = KeyPlus().urlkeyPlusSub(
        Url().boardDelete + '$deleteId&summonerName=$deleteName');
    final response = await http.get(url);
    print(url);
    String body = '';

    if (response.statusCode == 200) {
      body = utf8.decode(response.bodyBytes);
    } else {
      print('boardDelete Error!');
    }
    /* var jsonData = json.decode(body);
    if (mounted) {
      setState(() {
      });
    } */
  } catch (e) {
    print('boardDelete error = $e');
    //boardCommentSearch();
  }
} */

class ShortString {
  subStringFunction(String text) {
    var shortText;
    if (text.length > 15) {
      shortText = text.substring(0, 15);
      text = shortText + '...';
    }
    return text;
  }
}
