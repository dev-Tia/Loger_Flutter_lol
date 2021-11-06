/* import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/Create_Party/CP_main.dart';
import 'package:gap/In_Playing/map.dart';
import 'package:gap/Record/champlist.dart';
import 'package:gap/backUp/Search_Room/SR_main.dart';
import 'package:gap/login_test_en/sign_in.dart';

Drawer sideNav(){
  return Drawer(
    child: Stack(
      children: <Widget> [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
            )
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('소환사 정보')
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.details, 
                color: Colors.white
              ),
              title: Text("소환사 "),
              
              onTap: (){
              }
            ),      
          ],
        ),
      ],
    ),
  );
}

const double j_main_back = 200.0;

class Jmain extends StatelessWidget {
  
String _nameText() {
  if (name == null){
    return '이름없음';
  }else
  return name;
} 
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_nameText() + "님 하잉",
          // +name,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7)
            ),
          ),
          backgroundColor: Color.fromRGBO(76 , 207, 176, 1)
        ),
        backgroundColor: Color.fromRGBO(18 , 34, 47, 1),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(
                 (MediaQuery.of(context).size.width).round()/4.3,0,0,0
                //  (MediaQuery.of(context).size.height).round()/
                // (MediaQuery.of(context).size.width).round()/1, 
                // (MediaQuery.of(context).size.height).round()/1,
              ),
              width: (MediaQuery.of(context).size.width).round()/1.8,
              height: (MediaQuery.of(context).size.height).round()/2.5,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image:  AssetImage('images/etc/j_main_back.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: <Widget>[
              
              //너 내 동료가 되어라//
                Container(     
                  width: (MediaQuery.of(context).size.width).round()/3.0,
                  height: (MediaQuery.of(context).size.height).round()/4.3,
                  margin: EdgeInsets.fromLTRB(
                    (MediaQuery.of(context).size.width).round()/8, 
                    (MediaQuery.of(context).size.height).round()/2.7, 
                    (MediaQuery.of(context).size.width).round()/10.5, 
                    (MediaQuery.of(context).size.height).round()/10,
                  ),
                  child: RaisedButton(                    
                    elevation: 9,
                    color: Color.fromRGBO(18 , 34, 47, 1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CPmain()),
                      );
                    },
                    padding: EdgeInsets.all(0.0),                    
                    child: Image.asset('images/etc/mainB.png',
                      fit:BoxFit.cover
                    ),
                  ),
                ),
                //너 내 동료가 되어라//

                //추천 소환사 보기//
                Container(     
                  width: (MediaQuery.of(context).size.width).round()/3.0,
                  height: (MediaQuery.of(context).size.height).round()/4.3,
                  margin: EdgeInsets.fromLTRB(
                    0,
                    (MediaQuery.of(context).size.height).round()/2.7, 
                    0, 
                    (MediaQuery.of(context).size.height).round()/10,
                  ),
                  child: RaisedButton(                    
                    elevation: 9,
                    color: Color.fromRGBO(18 , 34, 47, 1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SRmain()),
                      );
                    },
                    padding: EdgeInsets.all(0.0),                    
                    child: Image.asset('images/etc/mainL.png',
                      fit:BoxFit.cover
                    ),
                  ),
                ),
               
              ],
            ),
            
            Row(
              children: <Widget>[
                //나 너의 동료가 될께//
                Container(     
                  width: (MediaQuery.of(context).size.width).round()/3.0,
                  height: (MediaQuery.of(context).size.height).round()/4.3,
                  margin: EdgeInsets.fromLTRB(
                    (MediaQuery.of(context).size.width).round()/8.0, 
                    (MediaQuery.of(context).size.height).round()/1.6, 
                    (MediaQuery.of(context).size.width).round()/20, 
                    (MediaQuery.of(context).size.height).round()/25,                    
                  ),
                  child: RaisedButton(                    
                    elevation: 9,
                    color: Color.fromRGBO(18 , 34, 47, 1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Champlist()),
                      );
                    },
                    padding: EdgeInsets.all(0.0),                    
                    child: Image.asset('images/etc/mainR.png',
                      fit:BoxFit.cover
                    ),
                  ),
                ),
                //나 너의 동료가 될께//

                //기타 버튼 //
                Container(     
                  width: (MediaQuery.of(context).size.width).round()/3.0,
                  height: (MediaQuery.of(context).size.height).round()/4.3,
                  margin: EdgeInsets.fromLTRB(
                    (MediaQuery.of(context).size.width).round()/20.0, 
                    (MediaQuery.of(context).size.height).round()/1.6, 
                    (MediaQuery.of(context).size.width).round()/12, 
                    (MediaQuery.of(context).size.height).round()/25,                    
                  ),
                  child: RaisedButton(                    
                    elevation: 9,
                    color: Color.fromRGBO(18 , 34, 47, 1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapTemp()),
                      );
                    },
                    padding: EdgeInsets.all(0.0),                    
                    child: Image.asset('images/etc/mainT.png',
                      fit:BoxFit.cover
                    ),
                  ),
                ),
                //기타 버튼 //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 */