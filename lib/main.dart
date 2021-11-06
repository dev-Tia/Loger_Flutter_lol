import 'dart:io' show Platform;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gaap/crossRoad.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:gaap/CommonValue.dart';
import 'package:gaap/PassAuth.dart';

import 'package:gaap/Providers/SummerProvider.dart';
import 'package:gaap/Providers/BoardProvider.dart';
import 'package:gaap/Providers/CheckProvider.dart';
import 'package:gaap/Providers/MatchProvider.dart';

import 'package:gaap/Url_List.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: CommonValue().debugShowBanner,

      title: 'GAAP - 너와 나의 어플차이!!!',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => new CheckProvider()),
          ChangeNotifierProvider(
              create: (_) => new SummerProvider(null, null, null, null)),
          ChangeNotifierProvider(create: (_) => new BoardProvider(false)),
          ChangeNotifierProvider(
              create: (_) =>
                  new MatchProvider(null, null, null, null, null, null)),
        ],
        child: MyHomePage(title: 'APP 메인!!!'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String temp;
  String key = '';
  String passKeyBackB;
  String passKeyFlutterB;

  @override
  void initState() {
    fetchVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);

    if (kReleaseMode) {
      print('release mode');

      if (Platform.isAndroid) {
        providerCheckOS.inputPlatform('Android', 'release');
        print('inputPlatform Android');
      }
      if (Platform.isIOS) {
        providerCheckOS.inputPlatform('IOS', 'release');
        print('inputPlatform IOS');
      }
    } else {
      print('debug mode');
      if (Platform.isAndroid) {
        providerCheckOS.inputPlatform('Android', 'debug');
        print('inputPlatform Android');
      }
      if (Platform.isIOS) {
        providerCheckOS.inputPlatform('IOS', 'debug');
        print('inputPlatform IOS');
      }
    }

    print('Main.dart 최종체크 : ' + providerCheckOS.getadUnitID);

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'GAAP - 너와 나의 어플차이!!!',
      home: dataState
          ? Container(color: Colors.white)
          : CommonValue().dogFoot
              ? CrossRoad()
              : (kReleaseMode ? PassAuth() : PassAuth()),
    );
  }

  bool dataState = true;

  data() {
    DateTime now = DateTime.now();
    String formattedDate =
        ((int.parse(DateFormat('yyyyMMdd').format(now)) - 20000000) * 7)
            .toString();
    String formattedDate2 = DateFormat('yyyyMMdd').format(now);
    print('formattedDate2 = $formattedDate2');
    print('now = $now');
    List<String> list = [];
    list = List<String>(formattedDate.length);

    for (int i = 0; i < formattedDate.length; i++) {
      list[i] = (formattedDate[i]);
    }

    temp = list[1];
    list[1] = list[5];
    list[5] = temp;

    temp = list[2];
    list[2] = list[4];
    list[4] = temp;

    for (int i = 0; i < list.length; i++) {
      key = key + list[i];
    }

    dataState = false;
    if (dataState == false) {
      setState(() {
        passKeyFlutter = key;
        passKeyFlutterB = passKeyFlutter;
      });
    }
  }

  fetchVersion() async {
    http.Response response = await http.get(Url().version);
    String body = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(body);
      if (mounted) {
        version = jsonData[0];
        print('version = $version');
        data();
      }
    } else {
      print('Failed to load post');
    }
  }
}
