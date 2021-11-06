/* import 'package:flutter/material.dart';
import 'package:gaap/Record/summon_record.dart';



class InputSummonerInfo extends StatefulWidget {
  @override
  _InputSummonerInfoState createState() => _InputSummonerInfoState();
}

class _InputSummonerInfoState extends State<InputSummonerInfo> {
 
  final myController = TextEditingController();

  @override
  void dispose() {
   
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('소환사 입력 역시 맨 처음 한번만'),
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          children:[            
            //방제적기//
            
            Container(
              margin: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
              child: Text('소환사 이름 적어주세요',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            
            Container(
              width: 270,
              height: 40,
              margin: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 30.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '방제목 적기',
                ),
                autofocus: true,
              ),
            ),

            Container(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(builder: (context) => SummonerRec()),
                    );
                },
              ),
            ),
          ]
        ),
      ), 
    );
  }
} */
