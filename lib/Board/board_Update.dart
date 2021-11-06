import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:gaap/Url_List.dart';
import 'package:gaap/Board/Board_Contents.dart';
import 'package:provider/provider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class M {
  BuildContext context;
  M(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class BoardUpdate extends StatelessWidget {
  final String originId;
  final String originName;
  final String originTitle;
  final String originTime;
  final String originContents;
  final String originImage;
  BoardUpdate(this.originId, this.originName, this.originTitle, this.originTime,
      this.originContents, this.originImage);

  @override
  Widget build(BuildContext context) {
    return _BoardUpdate(this.originId, this.originName, this.originTitle,
        this.originTime, this.originContents, this.originImage);
  }
}

class _BoardUpdate extends StatefulWidget {
  final String originId;
  final String originName;
  final String originTitle;
  final String originTime;
  final String originContents;
  final String originImage;

  _BoardUpdate(this.originId, this.originName, this.originTitle,
      this.originTime, this.originContents, this.originImage);
  @override
  _BoardUpdateState createState() => _BoardUpdateState();
}

class _BoardUpdateState extends State<_BoardUpdate> {
  String summonerName;
  String title;
  String contents;
  String result;
  int page;

  final TextEditingController _textControllerA = new TextEditingController();
  final TextEditingController _textControllerB = new TextEditingController();
  final TextEditingController _textControllerC = new TextEditingController();

  String originId;
  String originName;
  String originTitle;
  String originTime;
  String originContents;
  String originImage;
  List<String> origin;
  final _nativeAdController = NativeAdmobController();
  final _picker = ImagePicker();
  File imageF;
  final picker = ImagePicker();

  bool startCheck = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    originId = widget.originId;
    originName = widget.originName;
    originTitle = widget.originTitle;
    originContents = widget.originContents;
    originTime = widget.originTime;
    originImage = widget.originImage;

    if (startCheck == false) {
      _textControllerA.text = originName;
      _textControllerC.text = originTitle;
      _textControllerB.text = originContents;
      startCheck = true;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: appBar(),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              titleBar(),
              Expanded(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ad() {
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
        0,
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
              '게시물 수정',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentWriteArea() {
    return Container(
      alignment: Alignment.centerLeft,
      width: M(context).width,
      /*  decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              enabled: false,
              textInputAction: TextInputAction.done,
              controller: _textControllerA,
              //onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: originName,
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
          textFieldTitle(),
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
          textFieldContents(),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            width: /* (originImage != 'null') ? 300 :  */ (imageF != null)
                ? 300
                : (originImage != 'null') ? 300 : 0,
            height: /* (originImage != 'null') ? 300 :  */ (imageF != null)
                ? 300
                : (originImage != 'null') ? 300 : 0,
            child:
                /* (originImage != 'null')
                ? CachedNetworkImage(
                    imageUrl: corruntServer + originImage,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Text(''),
                  )
                :  */
                (imageF != null)
                    ? Image.file(imageF)
                    : (originImage != 'null')
                        ? CachedNetworkImage(
                            imageUrl: currentServer + originImage,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Text(''),
                          )
                        : Container(),
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
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 8),
      child: FlatButton(
        child: Text('글 수정'),
        onPressed: () {
          _handleSubmitted(_textControllerA.text);
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  Widget textFieldTitle() {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: M(context).height * 0.05,
      width: M(context).width,
      child: TextField(
        autofocus: false,
        textInputAction: TextInputAction.none,
        controller: _textControllerC,
        //onSubmitted: _handleSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: originTitle,
          //labelText: '제목',
        ),
      ),
    );
  }

  Widget textFieldContents() {
    return Container(
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
          //hintText: originContents,
          border: InputBorder.none,
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    ////
    summonerName = _textControllerA.text;
    contents = _textControllerB.text;
    title = _textControllerC.text;
    _textControllerA.clear();
    _textControllerB.clear();
    _textControllerC.clear();

    boardUpdate();
  }

  bool boardUpdateState = false;
  Future<void> boardUpdate() async {
    //summonerName = '신호등치킨';
    summonerName = summonerName.replaceAll(' ', '%20');
    //title = 'TEST to flutter';
    title = title.replaceAll(' ', '%20');
    //contents = '이건 flutter에서 보낸거야 tltle ㅎ;';
    contents = contents.replaceAll(' ', '%20');

    String url = Url().boardUpdate;

    try {
      Response response;
      Dio dio = new Dio();
      String body = '';
      if (imgState) {
        String fileName = imageF.path.split("/").last;
        FormData formData = new FormData.fromMap({
          'id': originId,
          'summonerName': summonerName,
          'title': title,
          'contents': contents,
          "img": await MultipartFile.fromFile(imageF.path, filename: fileName),
          'key': passKeyFlutter
        });
        response = await dio.post(url, data: formData);
      } else {
        {
          //String fileName = imageF.path.split("/").last;
          FormData formData = new FormData.fromMap({
            'id': originId,
            'summonerName': summonerName,
            'title': title,
            'contents': contents,
            "img": '',
            'key': passKeyFlutter
          });
          response = await dio.post(url, data: formData);
        }
      }
      if (response.statusCode == 200) {
        body = response.data;
      } else {
        throw Exception('Error!');
      }

      String oImg;

      var jsonData = json.decode(body);
      originId = jsonData['originId'].toString();
      originName = jsonData['summonerName'].toString();
      originTitle = jsonData['title'].toString();
      originTime = jsonData['time'].toString();
      originContents = jsonData['contents'].toString();
      oImg = jsonData['image'].toString();
      boardUpdateState = true;
      if (mounted) {
        if (originTime.isNotEmpty) {
          Navigator.of(context).pop();
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
                  //originImage
                  oImg,
                ),
              ));
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
      originImage = 'null';
      imageF = file;
    });
  }
}
