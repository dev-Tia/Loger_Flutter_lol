import 'package:flutter/material.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchKda extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchKda(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          callK(),
          callD(),
          callA(),
          callKDA(),
        ],
      ),
    );
  }

  //킬
  Widget callK() {
    return Container(
      child: Text(
        '${kills[i]} / ',
        style: TextStyle(fontSize: Size.height * 0.013),
      ),
    );
  }

  //데스
  Widget callD() {
    return Container(
      child: Text(
        '${deaths[i]} ',
        style: TextStyle(color: Colors.red, fontSize: Size.height * 0.013),
      ),
    );
  }

  //어시스트
  Widget callA() {
    return Container(
      child: Text(
        '/ ${assists[i]}  ',
        style: TextStyle(fontSize: Size.height * 0.013),
      ),
    );
  }

  //(킬+어시)/데스
  Widget callKDA() {
    return Container(
      child: Text(
        '${kda[i]} ',
        style: TextStyle(color: Colors.black54, fontSize: Size.height * 0.013),
      ),
    );
  }
}

//로딩 되지 않았을 때 kda 위젯
class MatchKdaLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              '0 / 0 / 0  0:0',
              style: TextStyle(fontSize: Size.height * 0.013),
            ),
          )
        ],
      ),
    );
  }
}
