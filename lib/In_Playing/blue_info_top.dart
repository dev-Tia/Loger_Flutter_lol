import 'package:flutter/material.dart';

class BlueTop extends StatefulWidget {
  @override
  createState() => new BlueTopState();
}

class BlueTopState extends State<BlueTop> {
  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    return  Column(
            children: <Widget>[
              //소환사 이름
              Container(
                margin: EdgeInsets.fromLTRB(
                  (m.width).round()/8.5, 
                  (m.height).round()/30, 
                  (m.width).round()/8, 
                  (m.height).round()/100,
                ),
                child: Text('신호등 치킨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  (m.width).round()/8.5, 
                  (m.height).round()/50, 
                  (m.width).round()/8, 
                  (m.height).round()/50,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.lightBlueAccent[400],
                    )
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  //챔피언 사진
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      (m.width).round()/8.5, 
                      (m.height).round()/50, 
                      (m.width).round()/50, 
                      (m.height).round()/80,
                    ),
                    width: m.width * 0.2,
                    child: InkWell(
                      child: Image.asset('images/api_source/champion_square/Garen.png'
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      //챔피언 이름
                      Container(
                        
                        margin: EdgeInsets.fromLTRB(
                          (m.width).round()/50, 
                          (m.height).round()/50, 
                          (m.width).round()/80, 
                          (m.height).round()/20,
                          ),
                        child: Text('가렌',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                          ),
                        ),
                      ),
                      //포지션
                      Container(
                      margin: EdgeInsets.fromLTRB(
                        (m.width).round()/50, 
                        (m.height).round()/50, 
                        (m.width).round()/50, 
                        (m.height).round()/50,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.lightBlueAccent[400],
                          )
                        ),
                      ),
                    ),
                    ],
                  ),
                  //승률
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              (m.width).round()/50, 
                              (m.height).round()/80, 
                              (m.width).round()/20, 
                              (m.height).round()/80,
                              ),
                            child: Text('총 123 게임',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              (m.width).round()/50, 
                              (m.height).round()/80, 
                              (m.width).round()/50, 
                              (m.height).round()/80,
                            ),
                            child: Text('승률 : 49%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                              ),
                            ),
                          ),
                          //KDA
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  (m.width).round()/50, 
                                  (m.height).round()/80, 
                                  (m.width).round()/50, 
                                  (m.height).round()/80,
                                ),
                                child: Text('KDA : ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                ),
                              ),                                     
                             Container(
                                margin: EdgeInsets.fromLTRB(
                                  (m.width).round()/50, 
                                  (m.height).round()/80, 
                                  (m.width).round()/50, 
                                  (m.height).round()/80,
                                ),
                                child: Text('5.5',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14
                                  ),
                                ),
                              ),                         
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  (m.width).round()/50, 
                                  (m.height).round()/80, 
                                  (m.width).round()/50, 
                                  (m.height).round()/80,
                                ),
                                child: Text('4.5',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  (m.width).round()/50, 
                                  (m.height).round()/80, 
                                  (m.width).round()/50, 
                                  (m.height).round()/80,
                                ),
                                child: Text('7.5',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  (m.width).round()/8.5, 
                  (m.height).round()/80, 
                  (m.width).round()/8, 
                  (m.height).round()/80,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.lightBlueAccent[400],
                    )
                  ),
                ),
              ),
              
              Row(
                children: <Widget>[
                  //랭크
                  Container(
                    width: (m.width).round()/4.0,
                    height: (m.height).round()/5.3,
                    margin: EdgeInsets.fromLTRB(
                      (m.width).round()/8, 
                      (m.height).round()/80, 
                      (m.width).round()/20, 
                      (m.height).round()/80,
                    ),
                    child: InkWell(
                      child: Image.asset('images/etc/E_Master.png'                          
                      ),
                    ),
                  ),
                  
                  Container(
                    width: (m.width).round()/2.5,
                    height: (m.height).round()/6,
                    margin: EdgeInsets.fromLTRB(
                      (m.width).round()/40, 
                      (m.height).round()/80, 
                      (m.width).round()/10, 
                      (m.height).round()/80,
                    ),
                    child: InkWell(
                      child: Image.asset('images/etc/chart1.png'                          
                      ),
                    ),
                  ),
                ],
              ),
              Container(                
                margin: EdgeInsets.fromLTRB(
                  (m.width).round()/8.5, 
                  (m.height).round()/80, 
                  (m.width).round()/8, 
                  (m.height).round()/80,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.lightBlueAccent[400],
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  (m.width).round()/8.5, 
                  (m.height).round()/80, 
                  (m.width).round()/8, 
                  (m.height).round()/80,
                ),
                child: Wrap(
                  spacing: 15.0, 
                  runSpacing: 2.0, 
                  children: <Widget>[
                    Chip(                    
                      backgroundColor: Colors.red[200],
                      elevation: 5,
                      label:  Text('용 학살자'),
                    ),
                    Chip(
                      backgroundColor: Colors.blue[200],
                      elevation: 5,
                      label:  Text('바론 헌터'),
                    ),
                    Chip(
                      backgroundColor: Colors.green[200],
                      elevation: 5,
                      label:  Text('와드 장인'),
                    ),
                    Chip(
                      backgroundColor: Colors.yellow[200],
                      elevation: 5,
                      label:  Text('3연승 중'),
                    ),
                    
                    Chip(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      label:  Text('알리스타 전문가',),
                    ),
                  ],
                )

              ),
            ],
          );
  }
}
