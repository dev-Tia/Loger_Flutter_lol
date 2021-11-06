import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:gaap/Providers/BoardProvider.dart';

import 'package:gaap/Url_List.dart';
import 'package:gaap/Board/board_Update.dart';

import 'package:gaap/Providers/CheckProvider.dart';

class MyUtility {
  BuildContext context;
  MyUtility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class BoardContents extends StatelessWidget {
  final String originId;
  final String originName;
  final String originTitle;
  final String originTime;
  final String originContents;
  final String originImage;

  BoardContents(this.originId, this.originName, this.originTitle,
      this.originTime, this.originContents, this.originImage);

  @override
  Widget build(BuildContext context) {
    return _BoardContents(originId, originName, originTitle, originTime,
        originContents, originImage);
  }
}

class _BoardContents extends StatefulWidget {
  final String originId;
  final String originName;
  final String originTitle;
  final String originTime;
  final String originContents;
  final String originImage;
  _BoardContents(this.originId, this.originName, this.originTitle,
      this.originTime, this.originContents, this.originImage);
  @override
  _BoarContentsState createState() => _BoarContentsState();
}

class _BoarContentsState extends State<_BoardContents> {
  final TextEditingController _textControllerA = new TextEditingController();
  final TextEditingController _textControllerB = new TextEditingController();

  String originId;
  String originName;
  String originTitle;
  String originTime;
  String originContents;
  String originImage;

  List<dynamic> boardComment;

  String name;
  String comment;

  String deleteCommentId;
  bool code;
  bool deleteCode;
  String dropdownValue = 'One';
  final _picker = ImagePicker();
  final _nativeAdController = NativeAdmobController();

  File imageF;
  final picker = ImagePicker();

  @override
  void initState() {
    boardCommentSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);

    print('=============_BoarContentsState Start=============');
    originId = widget.originId;
    originName = widget.originName;
    originTitle = widget.originTitle;
    originTime = widget.originTime;
    originContents = widget.originContents;
    originImage = widget.originImage;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          boardProvider.boardCheckT();
          print(boardProvider.boardC ? '트루래요!' : '폴스레요!');
          Navigator.pop(context);
        });
        return Future(() => true);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //appBar: appBar(),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  titleBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: Column(
                          children: <Widget>[
                            infoArea(),
                            contentsArea(),
                            commentArea(),
                            commentWriteArea(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ad() {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
    return Container(
      alignment: Alignment.center,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.blue[100])),
      padding: EdgeInsets.fromLTRB(
          MyUtility(context).width * 0.1, 5, MyUtility(context).width * 0.1, 5),
      height: MyUtility(context).height * 0.2,
      width: MyUtility(context).width * 0.9,
      //width: 200,
      child: NativeAdmob(
        loading: Container(),
        adUnitID: providerCheckOS.getadUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
      ),
    );
  }

  //상단 앱 바
  Widget appBar() {
    print('appBar() Start');
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      title: Center(
        child: Text(
          '게시판',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  //글 제목
  Widget titleBar() {
    print('titleBar() Start');
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Color.fromRGBO(2, 6, 89, 0.4),
      width: MyUtility(context).width,
      height: MyUtility(context).height * 0.07,
      child: Stack(
        children: <Widget>[
          titleBackButton(),
          titleMenuButton(),
          titleText(),
        ],
      ),
    );
  }

  //글 제목 글자
  Widget titleText() {
    return Center(
      child: Text(
        originTitle,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  //글 뒤로가기 버튼
  Widget titleBackButton() {
    return Positioned(
      left: 20,
      child: GestureDetector(
        child: Container(
          height: MyUtility(context).height * 0.07,
          //width: MyUtility(context).height * 0.07,
          margin: EdgeInsets.only(right: MyUtility(context).width * 0.85),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: MyUtility(context).height * 0.05,
          ),
        ),
        onTap: () {
          final boardProvider =
              Provider.of<BoardProvider>(context, listen: false);
          boardProvider.boardCheckT();
          print(boardProvider.boardC ? '트루래요!' : '폴스레요!');
          Navigator.pop(context);
          //Navigator.of(context).pop();
        },
      ),
    );
  }

  //글 수정 삭제
  Widget titleMenuButton() {
    return Positioned(
      right: 20,
      child: DropdownButton<String>(
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        //value: dropdownValue,
        icon: Icon(
          Icons.menu,
          color: Colors.black,
          size: MyUtility(context).height * 0.05,
        ),
        onChanged: (String newValue) {
          dropdownValue = newValue;
          if (dropdownValue == '글 수정') {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: BoardUpdate(
                    //originId
                    originId,
                    //originName
                    originName,
                    //originTitle
                    originTitle,
                    //originTime
                    originTime,
                    //originContents
                    originContents,
                    //originContents
                    originImage,
                  ),
                ));
            print('수정');
          } else if (dropdownValue == '글 삭제') {
            deleteDialog();
          }
        },
        items: <String>['글 수정', '글 삭제']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  deleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: new Text(
            '삭제하시겠습니까?',
            style: TextStyle(color: Colors.black),
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "네",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                boardDelete(originId, originName);
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text(
                "아니오",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //글 작성자 정보
  Widget infoArea() {
    print('infoArea() Start');
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blue[50]),
        ),
      ),
      width: MyUtility(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[infoAreaName(), infoAreaTime()],
      ),
    );
  }

  Widget infoAreaName() {
    return Container(
      margin: EdgeInsets.fromLTRB(MyUtility(context).width * 0.01, 0, 0,
          MyUtility(context).height * 0.00),
      child: Text(
        '$originName',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MyUtility(context).height * 0.018,
            color: Colors.black),
      ),
    );
  }

  Widget infoAreaTime() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          MyUtility(context).width * 0.01,
          MyUtility(context).height * 0.01,
          0,
          MyUtility(context).height * 0.02),
      child: Text('작성일 : $originTime',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MyUtility(context).height * 0.015,
              color: Colors.grey)),
    );
  }

  //글 내용
  Widget contentsArea() {
    print('contentsArea() Start');
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blue[50]),
        ),
      ),
      width: MyUtility(context).width,
      //height: MyUtility(context).height * 0.8,
      margin: EdgeInsets.fromLTRB(
          MyUtility(context).width * 0.01,
          MyUtility(context).height * 0.005,
          MyUtility(context).width * 0.01,
          0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          Container(
            height: originImage != 'null' ? 300 : 0,
            width: originImage != 'null' ? 300 : 0,
            margin:
                EdgeInsets.fromLTRB(0, 0, 0, MyUtility(context).width * 0.05),
            child: originImage != 'null'
                ? CachedNetworkImage(
                    imageUrl: currentServer + originImage,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Container(),
                  )
                : Container(),
          ),
          Container(
            //alignment: Alignment.center,
            decoration: BoxDecoration(),
            width: MyUtility(context).width,
            child: Text(originContents),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.blue[50]),
              ),
            ),
            width: MyUtility(context).width,
            height: MyUtility(context).height * 0.05,
          ),
          ad(),
        ],
      ),
    );
  }

  Widget contentsUnderArea() {
    return Container(
      color: Colors.blue[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //width: MyUtility(context).width,
            margin: EdgeInsets.fromLTRB(
                MyUtility(context).height * 0.01,
                MyUtility(context).height * 0.01,
                0,
                MyUtility(context).height * 0.01),
            child: boardCommentSearchState
                ? Text('댓글[' + (boardComment.length).toString() + ']')
                : Text('댓글[0]'),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Icon(
                Typicons.cw,
                color: Colors.black,
                //size: MyUtility(context).height * 0.02,
              ),
            ),
            onTap: () => reload(),
          ),
        ],
      ),
    );
  }

  //댓글 리스트
  Widget commentArea() {
    print('commentArea() Start');
    return boardCommentSearchState
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue[200],
                width: 2.0,
              ),
            ),
            width: MyUtility(context).width,
            //height: MyUtility(context).height * 0.75,
            child: Column(
              children: <Widget>[
                contentsUnderArea(),
                for (int i = 0; i < boardComment.length; i++)
                  commentAreaListTile(i)
              ],
            ),
          )
        : Container();
  }

  //댓글 내용
  Widget commentAreaListTile(int i) {
    deleteCommentId = boardComment[i][0];
    print('commentAreaListTile($i) start');
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blue[50]),
        ),
      ),
      //color: Colors.blue[100],
      child: Container(
        alignment: Alignment.bottomLeft,
        width: MyUtility(context).width,
/*         decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue[200],
            width: 2.0,
          ),
        ), */
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: MyUtility(context).width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0,
                        MyUtility(context).height * 0.01,
                        0,
                        MyUtility(context).height * 0.01),
                    child: Text(
                      boardComment[i][1],
                      style: TextStyle(
                          fontSize: MyUtility(context).height * 0.015),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    width: (boardComment[i][4] != 'null') ? 200 : 0,
                    height: (boardComment[i][4] != 'null') ? 200 : 0,
                    child: (boardComment[i][4] != 'null')
                        ? CachedNetworkImage(
                            imageUrl: currentServer + boardComment[i][4],
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Text(''),
                          )
                        : Placeholder(),
                  ),
                  Text(
                    boardComment[i][2],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MyUtility(context).height * 0.018),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0,
                        MyUtility(context).height * 0.01,
                        0,
                        MyUtility(context).height * 0.01),
                    child: Text(
                      boardComment[i][3],
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: MyUtility(context).height * 0.015),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Icon(
                  Typicons.cancel,
                  color: Colors.black,
                  size: MyUtility(context).height * 0.015,
                ),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                        SingleChildScrollView(child: new Text('삭제하시겠습니까?')),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Yes"),
                        onPressed: () {
                          boardCommentDelete(
                              boardComment[i][0], boardComment[i][1]);
                          Navigator.pop(context);
                          if (deleteCode == true) {}
                        },
                      ),
                      new FlatButton(
                        child: new Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 8),
      child: FlatButton(
        child: Text('이미지 업로드'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: SingleChildScrollView(
                    child: new Text(
                  '이미지를 선택해 주세요',
                  style: TextStyle(color: Colors.black),
                )),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "카메라",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      "갤러리",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  //댓글 쓰기
  Widget commentWriteArea() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MyUtility(context).width,
      decoration: BoxDecoration(
        //color: Colors.white,
        border: Border.all(color: Colors.blue[50]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            width: MyUtility(context).width,
            child: Text('댓글 쓰기'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8.0),
                height: MyUtility(context).height * 0.05,
                width: MyUtility(context).width * 0.5,
                child: TextField(
                  textInputAction: TextInputAction.done,
                  controller: _textControllerA,
                  //onSubmitted: _handleSubmitted,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '작성자',
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            width: (imageF != null) ? 50 : 0,
            height: (imageF != null) ? 50 : 0,
            child: (imageF != null) ? Image.file(imageF) : Placeholder(),
          ),
          Container(
            margin: EdgeInsets.all(6.0),
            color: Colors.blue[50],
            //padding: EdgeInsets.only(bottom: 40.0),
            //height: MyUtility(context).height * 0.15,
            width: MyUtility(context).width,
            child: TextField(
              textInputAction: TextInputAction.none,
              controller: _textControllerB,
              onSubmitted: _handleSubmitted,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              getImg(),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 8),
                child: FlatButton(
                  child: Text('댓글 쓰기'),
                  onPressed: () => _handleSubmitted(_textControllerA.text),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            height: MyUtility(context).height * 0.07,
          )
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    setState(() {
      name = _textControllerA.text;
      comment = _textControllerB.text;
    });
    _textControllerA.clear();
    _textControllerB.clear();
    boardCommentInput();
    imageF = null;
  }

  bool boardCommentSearchState = false;
  Future<void> boardCommentSearch() async {
    print('boardCommentSearch() Start');
    try {
      String url =
          KeyPlus().urlkeyPlusSub(Url().boardCommentSearch + widget.originId);
      final response = await http.get(url);
      print(url);
      String body = '';

      if (response.statusCode == 200) {
        body = utf8.decode(response.bodyBytes);
      } else {
        print('boardComment Error!');
      }
      var jsonData = json.decode(body);
      boardComment =
          new List.generate(jsonData['comment'].length, (i) => new List(5));
      for (int i = 0; i < jsonData['comment'].length; i++) {
        boardComment[i][0] = jsonData['comment'][i]['commentId'].toString();
        boardComment[i][1] = jsonData['comment'][i]['commentName'];
        boardComment[i][2] = jsonData['comment'][i]['commentContents'];
        boardComment[i][3] = jsonData['comment'][i]['commentTime'];
        boardComment[i][4] = jsonData['comment'][i]['originImage'].toString();

        if (jsonData['comment'].length == 0) {
          boardComment[i][0] = '댓글이 없습니다';
          boardComment[i][1] = '댓글이 없습니다';
          boardComment[i][2] = '댓글이 없습니다';
          boardComment[i][3] = '댓글이 없습니다';
          boardComment[i][4] = '댓글이 없습니다';
        }
      }
      if (mounted) {
        setState(() {
          print('boardCommentSearchState = $boardCommentSearchState');
          boardCommentSearchState = true;
        });
      }
    } catch (e) {
      print('boardCommentSearch error = $e');
      //boardCommentSearch();
    }
  }

  bool boardCommentInputState = false;
  Future<void> boardCommentInput() async {
    print('boardCommentInput() Start');

    try {
      String url = Url().boardComment;

      Response response;
      Dio dio = new Dio();
      if (imgState) {
        print('이미지 있음');
        String fileName = imageF.path.split("/").last;

        FormData formData = new FormData.fromMap({
          'id': widget.originId,
          'summonerName': name,
          'contents': comment,
          "img": await MultipartFile.fromFile(imageF.path, filename: fileName),
          'key': passKeyFlutter
        });
        response = await dio.post(url, data: formData);
      } else {
        print('이미지 없음');
        FormData formData = new FormData.fromMap({
          'id': widget.originId,
          'summonerName': name,
          'contents': comment,
          "img": '',
          'key': passKeyFlutter
        });
        response = await dio.post(url, data: formData);
      }
      String body = '';

/* 
      String url = KeyPlus().urlkeyPlusSub(Url().boardComment +
          '${widget.originId}&summonerName=$name&contents=$comment');
      final response = await http.get(url); */
      print(url);

      if (response.statusCode == 200) {
        body = response.data;
      } else {
        print('boardComment Error!');
      }
      var jsonData = json.decode(body);
      code = jsonData['code'];
      print('boardCommentInput = $code');
      if (mounted) {
        setState(() {
          boardCommentInputState = true;
          reload();
        });
      }
    } catch (e) {
      print('boardCommentInput error = $e');
      //boardCommentSearch();
    }
  }

  Future<void> boardCommentDelete(
      String deleteCommentId, String deleteCommentName) async {
    print('boardCommentInput() Start');
    try {
      String url = KeyPlus().urlkeyPlusSub(Url().boardCommentDelete +
          '$deleteCommentId&summonerName=$deleteCommentName');
      final response = await http.get(url);
      print(url);
      String body = '';

      if (response.statusCode == 200) {
        body = utf8.decode(response.bodyBytes);
      } else {
        print('boardComment Error!');
      }
      var jsonData = json.decode(body);
      code = jsonData['code'];
      print('boardCommentInput = $code');
      if (mounted) {
        setState(() {
          boardCommentInputState = true;
          reload();
        });
      }
    } catch (e) {
      print('boardCommentInput error = $e');
      //boardCommentSearch();
    }
  }

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
      var jsonData = json.decode(body);
      if (mounted) {
        deleteCode = jsonData['code'];
        setState(() {
          if (deleteCode == true) {
            final boardProvider =
                Provider.of<BoardProvider>(context, listen: false);

            boardProvider.boardCheckT();
            Navigator.pop(context);
          }
        });
      }
    } catch (e) {
      print('boardDelete error = $e');
      //boardCommentSearch();
    }
  }

  Future<void> reload() {
    if (boardCommentInputState) {
      boardCommentInputState = false;
      return boardCommentSearch();
    } else {
      return boardCommentSearch();
    }
  }

  bool imgState = false;
  void getImage(ImageSource source) async {
    print("getImageFromGallery");
    PickedFile image = await _picker.getImage(source: source);
    File file;
    if (image != null) {
      file = File(image.path);
    } else {
      file = null;
    }
    //var image = await ImagePicker.pickImage(source: source);

    setState(() {
      imgState = true;
      imageF = file;
    });
  }
}
