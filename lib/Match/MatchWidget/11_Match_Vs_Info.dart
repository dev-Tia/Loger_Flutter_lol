import 'package:flutter/material.dart';

import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchVsInfo extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Size.height * 0.02),
      width: Size.width,
      height: Size.height * 0.1,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                totalName(),
                totalVsbar(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget totalName() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Total Kill',
              style: TextStyle(fontSize: Size.height * 0.015),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Size.height * 0.02),
          ),
          Container(
            child: Text(
              'Total Gold',
              style: TextStyle(fontSize: Size.height * 0.015),
            ),
          ),
        ],
      ),
    );
  }

  Widget totalVsbar() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: Size.width * 0.02),
                child: Text(
                  '$killsTotalA',
                  style: TextStyle(fontSize: Size.height * 0.01),
                ),
              ),
              Container(
                  height: Size.height * 0.015,
                  width: (Size.width * killsTotal) * 0.5,
                  color: Colors.blue[700]),
              Container(
                  height: Size.height * 0.015,
                  width: (Size.width * (1 - killsTotal)) * 0.5,
                  color: Colors.red[700]),
              Container(
                margin: EdgeInsets.only(left: Size.width * 0.02),
                child: Text(
                  '$killsTotalB',
                  style: TextStyle(fontSize: Size.height * 0.01),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: Size.height * 0.02),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: Size.width * 0.02),
                    child: Text(
                      '$goldEarnedA',
                      style: TextStyle(fontSize: Size.height * 0.01),
                    ),
                  ),
                  Container(
                      height: Size.height * 0.015,
                      width: (Size.width * goldEarned) * 0.5,
                      color: Colors.blue[700]),
                  Container(
                      height: Size.height * 0.015,
                      width: (Size.width * (1 - goldEarned)) * 0.5,
                      color: Colors.red[700]),
                  Container(
                    margin: EdgeInsets.only(left: Size.width * 0.02),
                    child: Text(
                      '$goldEarnedB',
                      style: TextStyle(fontSize: Size.height * 0.01),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MatchVsInfoLoad extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Size.height * 0.02),
      width: Size.width,
      height: Size.height * 0.1,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                totalName(),
                totalVsbar(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget totalName() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Total Kill',
              style: TextStyle(fontSize: Size.height * 0.015),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Size.height * 0.02),
          ),
          Container(
            child: Text(
              'Total Gold',
              style: TextStyle(fontSize: Size.height * 0.015),
            ),
          ),
        ],
      ),
    );
  }

  Widget totalVsbar() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: Size.width * 0.02),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: Size.height * 0.01),
                ),
              ),
              Container(
                  height: Size.height * 0.015,
                  width: (Size.width * 0.5) * 0.5,
                  color: Colors.blue[700]),
              Container(
                  height: Size.height * 0.015,
                  width: (Size.width * (1 - 0.5)) * 0.5,
                  color: Colors.red[700]),
              Container(
                margin: EdgeInsets.only(left: Size.width * 0.02),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: Size.height * 0.01),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: Size.height * 0.02),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: Size.width * 0.02),
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: Size.height * 0.01),
                    ),
                  ),
                  Container(
                      height: Size.height * 0.015,
                      width: (Size.width * 0.5) * 0.5,
                      color: Colors.blue[700]),
                  Container(
                      height: Size.height * 0.015,
                      width: (Size.width * (1 - 0.5)) * 0.5,
                      color: Colors.red[700]),
                  Container(
                    margin: EdgeInsets.only(left: Size.width * 0.02),
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: Size.height * 0.01),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
