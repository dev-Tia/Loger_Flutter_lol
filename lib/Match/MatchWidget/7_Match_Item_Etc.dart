import 'package:flutter/material.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';
import 'package:gaap/Match/MatchWidget/8_Match_Item.dart';
import 'package:gaap/Match/MatchWidget/9_Match_Etc.dart';

class MatchItemEtc extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchItemEtc(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MatchItem(i),
          spacing(),
          MatchEtc(i),
        ],
      ),
    );
  }

  Widget spacing() {
    return Container(
      height: Size.width * 0.015,
    );
  }
}

//로딩 되지 않았을 때 소환사명 티어 KDA 위젯
class MatchItemEtcLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MatchItemLoad(),
          spacing(),
          MatchEtcLoad(),
        ],
      ),
    );
  }

  Widget spacing() {
    return Container(
      height: Size.width * 0.015,
    );
  }
}
