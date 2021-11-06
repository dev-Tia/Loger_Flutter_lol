import 'package:flutter/material.dart';

import 'package:gaap/CrossRoad.dart';
import 'package:gaap/Bottom_nav.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
//Terms Text-------------------------------------------------------------------------------
            Container(
              margin: EdgeInsets.fromLTRB(
                (MediaQuery.of(context).size.width).round() / 20,
                (MediaQuery.of(context).size.height).round() / 8.5,
                (MediaQuery.of(context).size.width).round() / 2.3,
                (MediaQuery.of(context).size.height).round() / 80,
              ),
              child: Text(
                'Terms',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black.withOpacity(0.6),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 10.0,
                      color: Color.fromARGB(200, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 15.0,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ), //-- Terms

//네모-------------------------------------------------------------------------------
            Container(
              margin: EdgeInsets.fromLTRB(
                (MediaQuery.of(context).size.width).round() / 10,
                (MediaQuery.of(context).size.width).round() / 30,
                (MediaQuery.of(context).size.width).round() / 10,
                (MediaQuery.of(context).size.width).round() / 20,
              ),
              height: (MediaQuery.of(context).size.width).round() / 0.85,
              width: (MediaQuery.of(context).size.width).round() / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue[900],
                  width: 2.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(2, 2),
                  ),
                ],
              ),

//약관 글씨-------------------------------------------------------------------------
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width).round() / 12,
                  (MediaQuery.of(context).size.width).round() / 15,
                  (MediaQuery.of(context).size.width).round() / 10,
                  (MediaQuery.of(context).size.width).round() / 20,
                ),
                child: Text('약관!!!'),
              ), //--약관글씨
            ), //-- 네모
//버튼-----------------------------------------------------------------------------------------------
            Container(
              child: Row(children: <Widget>[
//비동의------------------------------------------------------------------------------------
                Container(
                  margin: EdgeInsets.fromLTRB(
                    (MediaQuery.of(context).size.width).round() / 6,
                    (MediaQuery.of(context).size.width).round() / 40,
                    (MediaQuery.of(context).size.width).round() / 50,
                    (MediaQuery.of(context).size.width).round() / 30,
                  ),
                  height: (MediaQuery.of(context).size.width).round() / 8,
                  width: (MediaQuery.of(context).size.width).round() / 3.5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => CrossRoad()),
                      );
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("비 동의", style: TextStyle(fontSize: 16)),
                  ),
                ),

//동의---------------------------------------------------------------------------------------
                Container(
                  margin: EdgeInsets.fromLTRB(
                    (MediaQuery.of(context).size.width).round() / 15,
                    (MediaQuery.of(context).size.width).round() / 40,
                    (MediaQuery.of(context).size.width).round() / 50,
                    (MediaQuery.of(context).size.width).round() / 30,
                  ),
                  height: (MediaQuery.of(context).size.width).round() / 8,
                  width: (MediaQuery.of(context).size.width).round() / 3.5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav()),
                      );
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("동의", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
// 회원가입 페이지 //
