import 'package:flutter/material.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchTopInfo extends StatelessWidget {
  final String winState;
  final String queueType;
  final String gameCreation;
  final String gameDuration;
  MatchTopInfo(
      this.winState, this.queueType, this.gameCreation, this.gameDuration);

  @override
  Widget build(BuildContext context) {
    Size().init(context);

    return Column(
      children: <Widget>[
        Container(
          color: winState == '승' ? Colors.blue : Colors.red,
          width: Size.width,
          height: Size.height * 0.08,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: topState(context),
        ),
      ],
    );
  }

  Widget topState(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        iconAndWin(context),
        gameInfo(),
      ],
    );
  }

  //승패
  Widget iconAndWin(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.fromLTRB(
                Size.height * 0.01, 0, Size.height * 0.01, 0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: Size.height * 0.03,
            ),
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              Size.height * 0.01, 0, Size.height * 0.01, Size.height * 0.01),
          child: Text(
            winState == '승' ? '승리' : '패배',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Size.height * 0.03),
          ),
        ),
      ],
    );
  }

  Widget gameInfo() {
    return Container(
      margin: EdgeInsets.all(Size.height * 0.01),
      child: Text(
        '$queueType | $gameCreation | $gameDuration',
        style: TextStyle(color: Colors.white, fontSize: Size.height * 0.02),
      ),
    );
  }
}
