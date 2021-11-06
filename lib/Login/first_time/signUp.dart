import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

import 'package:gaap/Login/Google/Google_Login2.dart';
import 'package:gaap/Login/Apple/Apple_Login.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);

    return Scaffold(
        body: Column(
      children: <Widget>[
        contents(context),
        providerCheckOS.getplatform=='IOS'?apple(context):google(context),        
//facebook---------------------------------------------------------------------------
        Container(
          margin: EdgeInsets.fromLTRB(
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 30,
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 80,
          ),
          width: (MediaQuery.of(context).size.width).round() / 1.2,
          height: (MediaQuery.of(context).size.height).round() / 17,
          child: RaisedButton(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white10)),
            onPressed: () {
              print('facebook 로그인 클릭');
            },
            color: Colors.blue[800],
            textColor: Colors.white,
            child: Text("facebook      (Not Yet !)",
                style: TextStyle(fontSize: 18)),
          ),
        ),
// logout-------------------------------------------------------------------------------------
        Container(
          margin: EdgeInsets.fromLTRB(
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 30,
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 80,
          ),
          width: (MediaQuery.of(context).size.width).round() / 1.2,
          height: (MediaQuery.of(context).size.height).round() / 17,
          child: RaisedButton(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white10)),
            onPressed: () {
              logOut(context);
            },
            color: Colors.blueGrey,
            textColor: Colors.black,
            child: Text("logout", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    ));
  }
}

Widget contents(context) {
  return Column(
    children: <Widget>[
//텍스트--------------------------------------------------------------------------------------
      Container(
        margin: EdgeInsets.fromLTRB(
          (MediaQuery.of(context).size.width).round() / 3.5,
          (MediaQuery.of(context).size.width).round() / 4,
          (MediaQuery.of(context).size.width).round() / 4.8,
          (MediaQuery.of(context).size.width).round() / 50,
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 40),
        ),
      ),
//텍스트--------------------------------------------------------------------------------------
      Container(
        margin: EdgeInsets.fromLTRB(
          10,
          (MediaQuery.of(context).size.width).round() * 0.1,
          10,
          (MediaQuery.of(context).size.width).round() * 0.1,
        ),
        child: Text(
          "[GAAP] isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing Riot Games properties. Riot Games, and all associated properties are trademarks or registered trademarks of Riot Games, Inc.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    ],
  );
}

Widget google(context){
  //Google--------------------------------------------------------------------------------------
        return Container(
          margin: EdgeInsets.fromLTRB(
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() /10,
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 80,
          ),
          width: (MediaQuery.of(context).size.width).round() / 1.2,
          height: (MediaQuery.of(context).size.height).round() / 17,
          child: RaisedButton(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white10)),
            onPressed: () {
              googleLogin(context);
            },
            color: Colors.red[900],
            textColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.android,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                Text("Google", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
}

Widget apple(context){
  return         Container(
          margin: EdgeInsets.fromLTRB(
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 30,
            (MediaQuery.of(context).size.width).round() / 10,
            (MediaQuery.of(context).size.height).round() / 80,
          ),
          width: (MediaQuery.of(context).size.width).round() / 1.2,
          height: (MediaQuery.of(context).size.height).round() / 17,
          child: RaisedButton(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white10)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppleLogin()),
              );
            },
            color: Colors.black,
            textColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.dvr,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                Text("Apple", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
}

Future<void> googleLogin(context) async {
  print('googleLogin!');
  GoogleLogin2().signInWithGoogleOAUTH(context).then((value) {
    print('파아아아아아압!');

    Navigator.pop(context);
  });
}

void logOut(context) {
  print('로그아웃버튼!');
  GoogleLogin2().googleLogOut(context).then((value) => Navigator.pop(context));
}
