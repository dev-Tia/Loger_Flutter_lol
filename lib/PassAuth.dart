import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/SummerProvider.dart';

import 'package:gaap/Url_List.dart';
import 'package:gaap/bottom_nav.dart';

import 'package:gaap/CommonValue.dart';

import 'package:gaap/Login/first_time/signUp.dart';
import 'package:gaap/Login/Google/Google_Login2.dart';
import 'package:gaap/Login/first_time/InputSummonerName.dart';

class MyUtility {
  BuildContext context;
  MyUtility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class PassAuth extends StatefulWidget {
  @override
  PassAuthState createState() => PassAuthState();
}

class PassAuthState extends State<PassAuth> {
  @override
  void initState() {
    print(
        '------------_PassAuthState initState() 시작-----------$passKeyFlutter');
    GoogleLogin2().currentUser(context).then((value) => currentSummonerName());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('☆☆☆☆☆☆☆☆☆☆☆☆ PassAuth 시작합니다 ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆');
    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: true);
    if (providerSummonerName.summerName == null) {
      currentSummonerName();
    }

    print('providerSummonerName.uid : ${providerSummonerName.uid}');
    print(
        'providerSummonerName.summerName : ${providerSummonerName.summerName}');

    return MaterialApp(

      debugShowCheckedModeBanner: CommonValue().debugShowBanner,

      home: Scaffold(
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            images(),
            contents(),
            riot(),
            /* login(),
            inputSummonerName(), */
          ],
        ),
      ),
    );
  }

  Widget images() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage('images/etc/lol.png'),
          ),
          Image(
            image: AssetImage('images/etc/Crab.v1.gif'),
          )
        ],
      ),
    );
  }

  Widget contents() {
    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: true);

    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 0.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                (providerSummonerName.uid != null) ? '완료' : '로그인 정보 가져오는중',
                style: TextStyle(
                    fontSize: MyUtility(context).height * 0.028,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              Text(
                (providerSummonerName.summerName != null)
                    ? '완료'
                    : '소환사 정보 가져오는중',
                style: TextStyle(
                    fontSize: MyUtility(context).height * 0.028,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ]));
  }

  Widget riot() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(
        10,
        (MediaQuery.of(context).size.width).round() * 0.1,
        10,
        (MediaQuery.of(context).size.width).round() * 0.1,
      ),
      child: Text(
        "[GAAP] isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing Riot Games properties. Riot Games, and all associated properties are trademarks or registered trademarks of Riot Games, Inc.",
        style: TextStyle(
          fontSize: MyUtility(context).height * 0.03,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget login() {
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('로그인', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  ).then((value) => currentSummonerName());
                },
              ),
            ]));
  }

  Widget inputSummonerName() {
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('소환사 이름 확인', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  inputSummonerDialog();
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputSummonerName()),
                  ); */
                },
              ),
            ]));
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

  void inputSummonerDialog() {
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

  void currentSummonerName() async {
    print("currentSummonerName 확인하고있어요!!");

    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);

    final response = await http.get(KeyPlus().urlkeyPlusSub(
        AuthUrl().checkSummonerName + '?uid=' + providerSummonerName.uid));

    print('URL : ' +
        KeyPlus().urlkeyPlusSub(
            AuthUrl().checkSummonerName + '?uid=' + providerSummonerName.uid));

    String body;

    if (response.statusCode == 200) {
      body = utf8.decode(response.bodyBytes);
      var jsonData = json.decode(body);

      print("jsonData['code']" + jsonData['code'].toString());

      if (jsonData['code'] == 1) {
        providerSummonerName.inputSummerName(jsonData['status']);

        champ(providerSummonerName.summerName).then((value) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
          );
        });
      } else {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InputSummonerName()),
        );
/*         Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => InputSummonerName(),
            ),
            (Route<dynamic> route) => false); */
        print('소환사 이름 입력 필요');
      }
    } else {
      throw Exception('Fail');
    }
  }

  Future<void> champ(String summonerName) async {
    print('champ start');
    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    http.Response response;
    if (summonerName != '') {
      summonerName = summonerName.replaceAll(' ', '%20');
      try {
        response = await http
            .get(KeyPlus().urlkeyPlusSub(Url().summonerName + summonerName));
        String body = '';
        if (response.statusCode == 200) {
          body = utf8.decode(response.bodyBytes);
          var jsonData = json.decode(body);
          if (jsonData['code'] == 'error') {
            if (mounted) {
              setState(() {
                print(
                    '#############################################################3');
                print('re');
              });
            }
          } else {
            if (mounted) {
              //getName = jsonData['summonerName'];
              providerSummonerName
                  .inputSummerIcon(jsonData['profileIconId'].toString());
              providerSummonerName
                  .inputSummerLevel(jsonData['summonerLevel'].toString());
              //getLevel = jsonData['summonerLevel'].toString();
              print('소환사 이름 =' + jsonData['summonerName'].toString());
              print('소환사 레벨 = ' + jsonData['summonerLevel'].toString());
            }
          }
        } else {
          print('Fail');
        }
      } catch (e) {
        print('champ error = $e');
      }
    } else {
      if (mounted) {
        setState(() {
          print(
              '#############################################################4');
          print('re');
        });
      }
    }
  }
}
