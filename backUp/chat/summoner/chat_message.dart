import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

const String _name = "왼손은 흑염룡";

class ChatMessage extends StatelessWidget {
  final String text;
  ChatMessage({this.text});

  @override
  Widget build(BuildContext context) {       
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round()/10.5,
        (MediaQuery.of(context).size.width).round()/80,
        (MediaQuery.of(context).size.width).round()/80, 
        (MediaQuery.of(context).size.width).round()/80,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width).round()/2.5,
                  (MediaQuery.of(context).size.width).round()/10,
                  (MediaQuery.of(context).size.width).round()/50, 
                  (MediaQuery.of(context).size.width).round()/50,
                ),
                child: Text(
                  _name, 
                  style: TextStyle(
                    color: Colors.grey[700], 
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  )
                ),
              ),
              Bubble(
                margin: BubbleEdges.only(top: 5),
                elevation: 6,
                alignment: Alignment.topLeft,
                nip: BubbleNip.rightTop,
                nipWidth: 3,
                color: Colors.yellow,
                child: Text(text,
                  style: TextStyle(
                    color: Colors.black87, 
                    fontSize: 14
                  ),
                ),
              ),
            ],
          ),
          
          Container(
            margin: EdgeInsets.fromLTRB(
              (MediaQuery.of(context).size.width).round()/15,
              (MediaQuery.of(context).size.width).round()/10,
              (MediaQuery.of(context).size.width).round()/20, 
              (MediaQuery.of(context).size.width).round()/10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'images/api_source/champion_square/Ashe.png', 
                width: 50, 
                height: 50,
              ),
            ),
          ),
        ],
      ),
    ); 
  }
}