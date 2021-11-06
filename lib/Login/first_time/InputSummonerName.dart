import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:gaap/Providers/SummerProvider.dart';
import 'package:gaap/PassAuth.dart';
import 'package:gaap/Url_List.dart';

class InputSummonerName extends StatefulWidget {
  @override
  InputSummonerNameState createState() => InputSummonerNameState();
}

class InputSummonerNameState extends State<InputSummonerName> {
  TextEditingController _textController = new TextEditingController();
  String uid;

  @override
  Widget build(BuildContext context) {
    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    uid = providerSummonerName.uid;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width).round() / 10,
                  (MediaQuery.of(context).size.width).round() / 1.5,
                  (MediaQuery.of(context).size.width).round() / 10,
                  (MediaQuery.of(context).size.width).round() / 20,
                ),
                height: (MediaQuery.of(context).size.width).round() / 1.4,
                width: (MediaQuery.of(context).size.width).round() / 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue[900],
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 4,
                      offset: Offset(3, 4),
                    ),
                  ],
                ),
//텍스트 ----------------------------------------------------------------------------
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        (MediaQuery.of(context).size.width).round() / 10,
                        (MediaQuery.of(context).size.width).round() / 8,
                        (MediaQuery.of(context).size.width).round() / 10,
                        (MediaQuery.of(context).size.width).round() / 40,
                      ),
                      child:
                          Text('소환사 이름을 적어주세요', style: TextStyle(fontSize: 18)),
                    ),
//텍스트필드 ----------------------------------------------------------------------------
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        (MediaQuery.of(context).size.width).round() / 10,
                        (MediaQuery.of(context).size.width).round() / 20,
                        (MediaQuery.of(context).size.width).round() / 10,
                        (MediaQuery.of(context).size.width).round() / 50,
                      ),
                      height: (MediaQuery.of(context).size.width).round() / 6,
                      width: (MediaQuery.of(context).size.width).round() / 1.2,
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _textController,
                                decoration: InputDecoration(
                                  hintText: "소환사 이름",
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.yellow,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
//버튼-------------------------------------------------------------------
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        (MediaQuery.of(context).size.width).round() / 30,
                        (MediaQuery.of(context).size.width).round() / 25,
                        (MediaQuery.of(context).size.width).round() / 50,
                        (MediaQuery.of(context).size.width).round() / 50,
                      ),
                      height: (MediaQuery.of(context).size.width).round() / 9,
                      width: (MediaQuery.of(context).size.width).round() / 5,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onPressed: () {
                          print('_textController.text====================' +
                              _textController.text);
                          print('uid====================' + uid);
                          inputSummonerName(_textController.text, uid);
                        },
                        color: Colors.blue[900],
                        textColor: Colors.white,
                        child: Text("동의", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  inputSummonerName(String summonerName, String uid) async {
    http.Response response = await http.get(KeyPlus().urlkeyPlusSub(
        Url().createSummonerName + 'summonerName=$summonerName&uid=$uid'));
    String body = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(body);
      if (mounted) {
        print(jsonData[0].toString());
        final providerSummonerName =
            Provider.of<SummerProvider>(context, listen: false);
        providerSummonerName.inputSummerName(summonerName);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PassAuth()),
            (Route<dynamic> route) => false);
      }
    } else {
      print('Failed to load post');
    }
  }
}
