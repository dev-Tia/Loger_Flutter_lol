import 'package:flutter/material.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchTierName extends StatelessWidget {
  //for문을 위한 MatchTNK에서 받아온 i
  final int i;
  MatchTierName(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[callName(), callTier()],
      ),
    );
  }

//소환사 이름
  Widget callName() {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.01),
      child: Text(
        ShortString().subStringFunction(summonName[i]),
        style: TextStyle(
            fontSize: Size.height * 0.013, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget callTier() {
    return Container(
      padding: EdgeInsets.all(1),
      color: tier[i] == 'Un'
          ? Colors.grey
          : tier[i].contains('I')
              ? Colors.brown
              : tier[i].contains('B')
                  ? Colors.brown[600]
                  : tier[i].contains('S')
                      ? Colors.grey[700]
                      : tier[i].contains('G')
                          ? Colors.amber[300]
                          : tier[i].contains('P')
                              ? Colors.lightBlue[300]
                              : tier[i].contains('D')
                                  ? Colors.deepPurple[400]
                                  : tier[i].contains('M')
                                      ? Colors.deepPurpleAccent[400]
                                      : tier[i].contains('GM')
                                          ? Colors.redAccent[700]
                                          : tier[i].contains('C')
                                              ? Colors.blueGrey[300]
                                              : Colors.transparent,
      child: Text(
        ' ${tier[i]} ',
        style: TextStyle(
            color: Colors.white,
            fontSize: Size.height * 0.01,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

//로딩 되지 않았을 때 소환사 이름 및 티어 위젯
class MatchTierNameLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          callName(),
        ],
      ),
    );
  }

  Widget callName() {
    return Container(
      child: Text(
        '불러오는 중',
        style: TextStyle(
            fontSize: Size.height * 0.013, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ShortString {
  subStringFunction(String text) {
    var shortText;
    if (text.length > 14) {
      shortText = text.substring(0, 14);
      text = shortText + '...';
    }
    return text;
  }
}
