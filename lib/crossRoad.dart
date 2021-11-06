import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:gaap/Bottom_nav.dart';
import 'package:gaap/Login/MainCheck.dart';
import 'package:gaap/WebView.dart';

import 'package:gaap/Providers/SummerProvider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

import 'package:gaap/Login/first_time/InputSummonerName.dart';
import 'package:gaap/Login/first_time/signUp.dart';

class CheckInit extends StatefulWidget {
  @override
  _CheckInitState createState() => _CheckInitState();
}

class _CheckInitState extends State<CheckInit> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(' ');
    print('☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆');
    print('☆☆☆☆☆☆☆☆☆☆☆☆ Check Init 시작합니다 ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆');
    print('☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆');
    print(' ');

    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(2, 6, 89, 0.7),
        animate: true);

    return MaterialApp(
      initialRoute: '/Ckeck',
      routes: {
        '/Ckeck': (context) => CrossRoad(), // 여기서 로그인 판단!!!
        '/Google_Login': (context) => SignUp(), // 구글로그인이 안되었을때
        '/Input_SummonerName': (context) =>
            InputSummonerName(), // 소환사 명이 입력 안되었을때
        '/BottomNav': (context) => BottomNav(), // 최종적으로 보낼 곳
      },
    );
  }
}

class CrossRoad extends StatefulWidget {
  @override
  _CrossRoadState createState() => _CrossRoadState();
}

class _CrossRoadState extends State<CrossRoad> {
  String rerere;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('☆☆☆☆☆☆☆☆☆☆☆☆ 크로스 로드 시작합니다 ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆');

    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: true);
    print('providerSummonerName.uid : ${providerSummonerName.uid}');

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              mainButton(),
              contents1(),
              contents2(),
              webView(),
              SingleChildScrollView(
                child: Consumer<SummerProvider>(
                  builder: (context, summerName, child) => Container(
                    height: 500,
                    child:
                        providerSummonerName.uid == null ? MainCheck() : SignUp(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('메인 페이지', style: TextStyle(fontSize: 24)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
          );
        },
      ),
    );
  }

  Widget webView() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('개발 : WebView & Admob', style: TextStyle(fontSize: 24)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebViewPage()),
          );
        },
      ),
    );
  }

  Widget mainCheckButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('개발 : Login & Check', style: TextStyle(fontSize: 24)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainCheck()),
          );
        },
      ),
    );
  }

  Widget contents1() {
    // Provider.of 로 쓸때만 구독
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);

    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Mode&OS : ${providerCheckOS.checkTextValue}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ]));
  }

  Widget contents2() {
    // Consumer 로 상시 구독
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Consumer<SummerProvider>(
                builder: (context, summerName, child) => Text(
                  'SummerName : ${summerName.summerName}',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ]));
  }
}
