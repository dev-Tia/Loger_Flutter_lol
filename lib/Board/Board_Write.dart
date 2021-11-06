import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'package:gaap/Url_List.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gaap/Board/Board_Contents.dart';
import 'package:gaap/Providers/CheckProvider.dart';

class M {
  BuildContext context;
  M(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class BoardWrite extends StatelessWidget {
  final int page;
  BoardWrite(this.page);

  @override
  Widget build(BuildContext context) {
    return _BoardWrite(page);
  }
}

class _BoardWrite extends StatefulWidget {
  final int page;
  _BoardWrite(this.page);
  @override
  _BoardWriteState createState() => _BoardWriteState();
}

class _BoardWriteState extends State<_BoardWrite> {
  String summonerName;
  String title;
  String contents;
  String result;
  int page;

  File imageF;
  final picker = ImagePicker();

  final TextEditingController _textControllerA = new TextEditingController();
  final TextEditingController _textControllerB = new TextEditingController();
  final TextEditingController _textControllerC = new TextEditingController();

  final _nativeAdController = NativeAdmobController();
  final _picker = ImagePicker();
  String originId;
  String originName;
  String originTitle;
  String originTime;
  String originContents;
  String image;
  bool code;
  List<String> origin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    page = widget.page;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: appBar(),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              titleBar(),
              Expanded(
                /*               child: Container(
                  height: M(context).height * 0.95 -
                      MediaQuery.of(context).padding.top,
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top), */
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      commentWriteArea(),
                      ad(),
                      /*  Container(
                    height: M(context).height * 0.05,
                  ) */
                    ],
                  ),
                ),
                /*  ), */
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ad() {
    print('ad() Start');
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
    return Card(
      shadowColor: Color.fromRGBO(2, 6, 89, 1),
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.yellow[600], width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.fromLTRB(
        (M(context).width).round() / 20,
        (M(context).width).round() / 20,
        (M(context).width).round() / 20,
        (M(context).height).round() / 70,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: M(context).height * 0.09,
        //width: 200,
        child: NativeAdmob(
          loading: Container(),
          adUnitID: providerCheckOS.getadUnitID,
          controller: _nativeAdController,
          type: NativeAdmobType.banner,
        ),
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      alignment: Alignment.center,
      color: Color.fromRGBO(2, 6, 89, 0.4),
      width: M(context).width,
      height: M(context).height * 0.07,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            height: M(context).height * 0.07,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: M(context).width * 0.85),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: M(context).height * 0.05,
                ),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Center(
            child: Text(
              '게시물 작성',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentWriteArea() {
    print('commentWriteArea() Start');
    return Container(
      alignment: Alignment.centerLeft,
      width: M(context).width,
      /*  decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            width: M(context).width,
            child: Text(
              '작성자',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            height: M(context).height * 0.05,
            width: M(context).width * 0.5,
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: _textControllerA,
              //onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //labelText: '작성자',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: M(context).width,
            child: Text(
              '제목',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            height: M(context).height * 0.05,
            width: M(context).width,
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: _textControllerC,
              //onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //labelText: '제목',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                //width: M(context).width,
                child: Text(
                  '내용',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            margin: EdgeInsets.all(8.0),
            //padding: EdgeInsets.only(bottom: 40.0),
            height: M(context).height * 0.35,
            width: M(context).width,
            child: TextField(
              textInputAction: TextInputAction.none,
              controller: _textControllerB,
              onSubmitted: _handleSubmitted,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            width: (imageF != null) ? 300 : 0,
            height: (imageF != null) ? 300 : 0,
            child: (imageF != null) ? Image.file(imageF) : Placeholder(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              getImg(),
              submit(),
            ],
          ),
        ],
      ),
    );
  }

  Widget getImg() {
    print('getImg() Start');
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

  Widget submit() {
    print('submit() Start');
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 8),
      child: FlatButton(
        child: Text('글 쓰기'),
        onPressed: () {
          _handleSubmitted(_textControllerA.text);
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  Widget galleryGet() {
    print('galleryGet() Start');
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 8),
      child: FlatButton(
        child: Text('갤러리'),
        onPressed: () {
          getImage(ImageSource.gallery);
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  Widget cameraGet() {
    print('cameraGet() Start');
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 8),
      child: FlatButton(
        child: Text('카메라'),
        onPressed: () {
          getImage(ImageSource.camera);
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  void _handleSubmitted(String text) {
    ////
    summonerName = _textControllerA.text;
    contents = _textControllerB.text;
    title = _textControllerC.text;
    boardWrite();
  }

  bool boardWriteState = false;
  Future<void> boardWrite() async {
    //summonerName = '신호등치킨';
    summonerName = summonerName.replaceAll(' ', '%20');
    //title = 'TEST to flutter';
    title = title.replaceAll(' ', '%20');
    //contents = '이건 flutter에서 보낸거야 tltle ㅎ;';
    contents = contents.replaceAll(' ', '%20');
    try {
      String url = Url().boardWrite;
      /* KeyPlus().urlkeyPlusSub(Url().boardWrite); */

      print(url);
      /* final response = await http.get(url);
      String body = '';
      String status;
      if (response.statusCode == 200) {
        body = utf8.decode(response.bodyBytes);
      } else {
        throw Exception('Error!');
      } */
      Response response;
      Dio dio = new Dio();

      if (imgState) {
        String fileName = imageF.path.split("/").last;

        FormData formData = new FormData.fromMap({
          'summonerName': summonerName,
          'title': title,
          'contents': contents,
          "img": await MultipartFile.fromFile(imageF.path, filename: fileName),
          'key': passKeyFlutter
        });
        response = await dio.post(url, data: formData);
      } else {
        FormData formData = new FormData.fromMap({
          'summonerName': summonerName,
          'title': title,
          'contents': contents,
          "img": '',
          'key': passKeyFlutter
        });
        response = await dio.post(url, data: formData);
      }
      print(response.data);
      String body = '';
      String status;
      body = (response.data);
      var jsonData = json.decode(body);
      originId = jsonData['originId'].toString();
      originName = jsonData['summonerName'].toString();
      originTitle = jsonData['title'].toString();
      originTime = jsonData['time'].toString();
      originContents = jsonData['contents'].toString();
      image = jsonData['image'].toString();
      code = jsonData['code'];
      status = jsonData['status'];
      boardWriteState = true;
      if (mounted) {
        if (code) {
          _textControllerA.clear();
          _textControllerB.clear();
          _textControllerC.clear();
          Navigator.of(context).pop();
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: BoardContents(
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
                  //image
                  image,
                ),
              ));
        } else if (code == false) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: SingleChildScrollView(
                    child: new Text(
                  status,
                  style: TextStyle(color: Colors.black),
                )),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "확인",
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
      }
    } catch (e) {
      print('boardWrite error = $e');
    }
  }

  bool imgState = false;
  void getImage(ImageSource source) async {
    print("getImageFromGallery");
    PickedFile image = await _picker.getImage(source: source);
    File file = File(image.path);
    setState(() {
      imgState = true;
      imageF = file;
    });
  }
}
