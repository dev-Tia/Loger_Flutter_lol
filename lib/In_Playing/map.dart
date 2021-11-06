/* import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gaap/In_Playing/blue_info.dart';
import 'package:gaap/In_Playing/red_info.dart';

class MapTemp extends StatefulWidget {
  @override
  _MapTempState createState() => _MapTempState();
}

class _MapTempState extends State<MapTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18 , 34, 47, 1),
      body: Column(
        children: <Widget>[    

            Container(
                height: (MediaQuery.of(context).size.height).round()/1.5,
                width: (MediaQuery.of(context).size.width).round()/1,
                margin: EdgeInsets.fromLTRB(
                0,
                (MediaQuery.of(context).size.height).round()/40, 
                0,
                (MediaQuery.of(context).size.height).round()/100, 
                ),
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image:  AssetImage('images/etc/map2.png'),
                ),
              ),
            ),
          
        
          Row(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height).round()/14,
                width: (MediaQuery.of(context).size.width).round()/3,
                margin: EdgeInsets.fromLTRB(
                   (MediaQuery.of(context).size.width).round()/10,
                   (MediaQuery.of(context).size.height).round()/100, 
                   (MediaQuery.of(context).size.width).round()/10,
                   (MediaQuery.of(context).size.height).round()/50, 
                   ),
                child: RaisedButton(
                  color: Colors.red[400],
                  child: Text('레드팀'),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RedInfo()),
                    );
                  },
                ),
              ),

              Container(
                height: (MediaQuery.of(context).size.height).round()/14,
                width: (MediaQuery.of(context).size.width).round()/3,
                margin: EdgeInsets.fromLTRB(
                   (MediaQuery.of(context).size.width).round()/50,
                   (MediaQuery.of(context).size.height).round()/100, 
                   (MediaQuery.of(context).size.width).round()/50,
                   (MediaQuery.of(context).size.height).round()/50, 
                   ),
                child: RaisedButton(
                  color: Colors.blue[400],
                  child: Text('블루팀'),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlueInfo()),
                    );
                  },
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
} */
