import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/SummerProvider.dart';

import 'package:gaap/Url_List.dart';
import 'package:gaap/CommonValue.dart';
import 'package:gaap/Login/Google/Google_Login.dart';
import 'package:gaap/Login/first_time/mTerms.dart';
import 'package:gaap/Login/first_time/signUp.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class MainCheck extends StatefulWidget {
  @override
  _MainCheckState createState() => _MainCheckState();
}

class _MainCheckState extends State<MainCheck> {
  bool _isLoggedIn;
  bool _isSummonerName;
  bool currentCheckSwitch;
  String userUID;
  String summonerName;

  void initState() {
    super.initState();

    _isLoggedIn = false;
    _isSummonerName = false;
    currentCheckSwitch = false;
    userUID = null;
    summonerName = null;

    currentUser();
  }

  @override
  Widget build(BuildContext context) {
    print("MainCheck 랜더링 시작!!!");

    // 트리거 시작!!!
    if (_isLoggedIn) {
      print("로그인 확인되었습니다");
      if (!currentCheckSwitch) {
        currentSummonerName().then((value) => () {
              if (_isSummonerName) {
                print("소환사명 확인되었습니다");
              } else {
                print("소환사명 확인되지 않습니다");
              }
            });
      }
    } else {
      print("로그인 확인되지 않습니다");
    }

    return MaterialApp(

      debugShowCheckedModeBanner: CommonValue().debugShowBanner,

        home: Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
          contents(),
          goGoogleLoginButton(),
          termTemp(),
          inputSummoner(),
          signupTemp(),
          pop(),
        ])));
  }

  Widget contents() {
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'userUID : ',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
              Text(
                (userUID != null) ? userUID : 'NULL',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.right,
              ),
              Consumer<SummerProvider>(
                builder: (context, summerName, child) => Text(
                  'SummerName : ${summerName.summerName}',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ]));
  }

  Widget goGoogleLoginButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('Google 로그인 페이지로', style: TextStyle(fontSize: 24)),
        onPressed: googleLoginButton,
      ),
    );
  }

  Widget termTemp() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('임시 약관', style: TextStyle(fontSize: 24)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Terms()),
          );
        },
      ),
    );
  }

  Widget inputSummoner() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('소환사 이름 입력', style: TextStyle(fontSize: 24)),
        onPressed: () {
          inputSummonerDialog();
          /*  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputSummonerName()),
          ); */
        },
      ),
    );
  }

  final myController = TextEditingController();

  inputSummonerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            '소환사 명 입력',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: TextField(
                controller: myController,
                autocorrect: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.yellow[600],
                  ),
                  hintText: '소환사명 검색',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (text) {
                  setState(() {
                    print(
                        '#############################################################2');
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget signupTemp() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('임시회원가입', style: TextStyle(fontSize: 24)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
          );
        },
      ),
    );
  }

  Widget pop() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: RaisedButton(
        child: Text('POP', style: TextStyle(fontSize: 24)),
        onPressed: () {
          Navigator.pop(context, 'Nope!');
        },
      ),
    );
  }

  void googleLoginButton() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoogleLogin()),
    );
    setState(() {
      userUID = null;
      summonerName = null;

      if (result == 'login true') {
        currentUser();
        currentCheckSwitch = false;
      }
    });
  }

  void currentUser() async {
    print("currentUser 확인하고있어요!!");

    try {
      final FirebaseUser user = await _auth.currentUser();

      if (user != null) {
        print("user : " + user.toString());
        setState(() {
          print('setState userUID');
          userUID = user.uid;
          _isLoggedIn = true;
        });
      } else {
        setState(() {
          userUID = null;
          _isLoggedIn = false;
        });
      }
      print("userUID : " + userUID);
    } catch (e) {
      print('ERROR ERROR ERROR ERROR ERROR');
      print(e);
    }
  }

  Future<void> currentSummonerName() async {
    print("currentSummonerName 확인하고있어요!!");

    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);

    final response = await http.get(KeyPlus()
        .urlkeyPlusSub(AuthUrl().checkSummonerName + '?uid=' + userUID));

    print('URL : ' +
        KeyPlus()
            .urlkeyPlusSub(AuthUrl().checkSummonerName + '?uid=' + userUID));

    String body;

    if (response.statusCode == 200) {
      body = utf8.decode(response.bodyBytes);
      var jsonData = json.decode(body);

      print("jsonData['code']" + jsonData['code'].toString());

      if (jsonData['code'] == 1) {
        print('소환사 이름 setstate');
        setState(() {
          summonerName = jsonData['status'];
          _isSummonerName = true;
          currentCheckSwitch = true;
        });

        providerSummonerName.inputSummerName(summonerName);
      } else {
        print('소환사 이름 입력 필요');
      }
    } else {
      throw Exception('Fail');
    }
  }
}
