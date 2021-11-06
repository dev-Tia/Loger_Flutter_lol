import 'package:flutter/material.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';
import 'package:gaap/Match/MatchWidget/5_Match_Tier_Name.dart';
import 'package:gaap/Match/MatchWidget/6_Match_Kda.dart';

class MatchTNK extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchTNK(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.width * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MatchTierName(i),
          spacing(),
          MatchKda(i),
        ],
      ),
    );
  }

  Widget spacing() {
    return Container(
      height: Size.width * 0.04,
    );
  }
}

//로딩 되지 않았을 때 소환사명 티어 KDA 위젯
class MatchTNKLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MatchTierNameLoad(),
          spacing(),
          MatchKdaLoad(),
        ],
      ),
    );
  }

  Widget spacing() {
    return Container(
      height: Size.width * 0.01,
    );
  }
}
