import 'package:flutter/material.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchEtc extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchEtc(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          calltotlaCs(),
          callCs(),
        ],
      ),
    );
  }

  //킬
  Widget calltotlaCs() {
    return Container(
      child: Text(
        '${totalCs[i]} CS',
        style: TextStyle(color: Colors.grey, fontSize: Size.height * 0.013),
      ),
    );
  }

  //데스
  Widget callCs() {
    return Container(
      child: Text(
        '(${cs[i]})',
        style: TextStyle(color: Colors.grey, fontSize: Size.height * 0.013),
      ),
    );
  }
}

//로딩 되지 않았을 때 kda 위젯
class MatchEtcLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              '0 / 0 / 0  0:0',
              style:
                  TextStyle(color: Colors.grey, fontSize: Size.height * 0.013),
            ),
          )
        ],
      ),
    );
  }
}
