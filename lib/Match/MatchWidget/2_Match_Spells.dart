import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchSpells extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchSpells(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.01),
      child: Column(
        children: <Widget>[
          sepllAImg(),
          spacing(),
          spellBImg(),
        ],
      ),
    );
  }

  //첫번째 스펠 이미지
  Widget sepllAImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        color: Colors.blue[200],
        child: CachedNetworkImage(
          imageUrl: spellA[i],
          errorWidget: (context, url, error) => Icon(Icons.image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  //두 스펠 사이 공간
  Widget spacing() {
    return Container(
      height: Size.width * 0.01,
    );
  }

  //두번째 스펠 이미지
  Widget spellBImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        color: Colors.blue[400],
        child: CachedNetworkImage(
          imageUrl: spellB[i],
          errorWidget: (context, url, error) => Icon(Icons.image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

//로딩 되지 않았을 때 스펠 위젯
class MatchSpellsLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.01),
      child: Column(
        children: <Widget>[
          sepllAImg(),
          spacing(),
          spellBImg(),
        ],
      ),
    );
  }

  //첫번째 스펠 이미지
  Widget sepllAImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        color: Colors.blue[200],
      ),
    );
  }

  //두 스펠 사이 공간
  Widget spacing() {
    return Container(
      height: Size.width * 0.01,
    );
  }

  //두번째 스펠 이미지
  Widget spellBImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        color: Colors.blue[400],
      ),
    );
  }
}
