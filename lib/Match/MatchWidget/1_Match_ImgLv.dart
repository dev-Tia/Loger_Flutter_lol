import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:provider/provider.dart';

import 'package:gaap/Match/MatchData/MatchFunction.dart';
import 'package:gaap/Providers/MatchProvider.dart';

class MatchImgLv extends StatefulWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchImgLv(this.i);

  @override
  _MatchImgLv createState() => _MatchImgLv();
}

class _MatchImgLv extends State<MatchImgLv> {
  @override
  Widget build(BuildContext context) {
    int i = widget.i;
    return Container(
      margin: EdgeInsets.fromLTRB(Size.width * 0.01, 0, Size.width * 0.02, 0),
      padding: EdgeInsets.all(Size.width * 0.005),
      color: Colors.black,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          champImg(i),
          champLv(i),
        ],
      ),
    );
  }

//챔피언 이미지
  Widget champImg(int i) {
    final providerMatch = Provider.of<MatchProvider>(context, listen: true);
    return Container(
      width: Size.width * 0.11,
      height: Size.width * 0.11,
      color: Colors.blue[50],
      child: CachedNetworkImage(
        imageUrl: providerMatch.champUrl[i],
        errorWidget: (context, url, error) => Icon(Icons.image),
        fit: BoxFit.fill,
      ),
    );
  }

//챔피언 레벨
  Widget champLv(int i) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          left: BorderSide(
            width: Size.width * 0.005,
            color: Colors.black,
          ),
          top: BorderSide(
            width: Size.width * 0.005,
            color: Colors.black,
          ),
        ),
      ),
      child: Text(
        callgameInfoState ? champLevel[i] : '0',
        style: TextStyle(
            color: Color.fromRGBO(242, 226, 5, 1),
            fontSize: Size.height * 0.01,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

//로딩 되지 않았을 때 보이는 위젯
class MatchImgLvLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Size.width * 0.01, 0, Size.width * 0.02, 0),
      padding: EdgeInsets.all(Size.width * 0.005),
      color: Colors.black,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          champImg(),
          champLv(),
        ],
      ),
    );
  }

  Widget champImg() {
    return Container(
      width: Size.width * 0.11,
      height: Size.width * 0.11,
      color: Colors.blue[50],
    );
  }

  Widget champLv() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          left: BorderSide(
            width: Size.width * 0.005,
            color: Colors.black,
          ),
          top: BorderSide(
            width: Size.width * 0.005,
            color: Colors.black,
          ),
        ),
      ),
      child: Text(
        '0',
        style: TextStyle(
            color: Color.fromRGBO(242, 226, 5, 1),
            fontSize: Size.height * 0.01),
      ),
    );
  }
}
