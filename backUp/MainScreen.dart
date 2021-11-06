// import 'package:flutter/material.dart';



// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//         home: Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 //프로필 사진----------------------
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.fromLTRB(
//                         (MediaQuery.of(context).size.width).round() / 10,
//                         (MediaQuery.of(context).size.height).round() / 10,
//                         (MediaQuery.of(context).size.width).round() / 30,
//                         (MediaQuery.of(context).size.height).round() / 40,
//                       ),
//                       width: (MediaQuery.of(context).size.width).round() / 3.5,
//                       height: (MediaQuery.of(context).size.width).round() / 3.5,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black54,
//                             blurRadius: 2.0,
//                             spreadRadius: 2.0,
//                             offset: Offset(2.0, 2.0),
//                           ),
//                         ],
//                         border: Border.all(color: Colors.yellow[600], width: 1),
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'images/api_source/champion_square/Annie.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
// //소환사 이름----------------------
//                 Container(
//                   margin: EdgeInsets.fromLTRB(
//                     (MediaQuery.of(context).size.width).round() / 50,
//                     (MediaQuery.of(context).size.height).round() / 5.5,
//                     (MediaQuery.of(context).size.width).round() / 50,
//                     (MediaQuery.of(context).size.height).round() / 50,
//                   ),
//                   child: Text(
//                     'name',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             ),
// //심플 전적-----------------------
//             Container(
//               child: InkWell(
//                 onTap: () {
//                   print('내정보보기');
//                 },
//                 child: Card(
//                   elevation: 5,
//                   color: Colors.white70,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.yellow[600], width: 2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   margin: EdgeInsets.fromLTRB(
//                     (MediaQuery.of(context).size.width).round() / 10,
//                     (MediaQuery.of(context).size.height).round() / 100,
//                     (MediaQuery.of(context).size.width).round() / 13,
//                     (MediaQuery.of(context).size.height).round() / 100,
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       //랭크 -----------------------
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.fromLTRB(
//                               (MediaQuery.of(context).size.width).round() / 10,
//                               (MediaQuery.of(context).size.height).round() / 60,
//                               (MediaQuery.of(context).size.width).round() / 30,
//                               (MediaQuery.of(context).size.height).round() / 80,
//                             ),
//                             width: (MediaQuery.of(context).size.width).round() /
//                                 12,
//                             height:
//                                 (MediaQuery.of(context).size.height).round() /
//                                     15,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage('images/etc/E_Diamond.png'),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(
//                               (MediaQuery.of(context).size.width).round() / 9.5,
//                               (MediaQuery.of(context).size.height).round() / 80,
//                               (MediaQuery.of(context).size.width).round() / 30,
//                               (MediaQuery.of(context).size.height).round() / 80,
//                             ),
//                             width: (MediaQuery.of(context).size.width).round() /
//                                 10,
//                             height:
//                                 (MediaQuery.of(context).size.height).round() /
//                                     20,
//                             child: Text(
//                               '다이아',
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ],
//                       ),
//                       //승률 %--------------------------
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.fromLTRB(
//                               (MediaQuery.of(context).size.width).round() / 7,
//                               (MediaQuery.of(context).size.height).round() / 23,
//                               (MediaQuery.of(context).size.width).round() / 30,
//                               (MediaQuery.of(context).size.height).round() /
//                                   100,
//                             ),
//                             width: (MediaQuery.of(context).size.width).round() /
//                                 10,
//                             height:
//                                 (MediaQuery.of(context).size.height).round() /
//                                     35,
//                             child: Text(
//                               '52%',
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(
//                               (MediaQuery.of(context).size.width).round() / 7.0,
//                               (MediaQuery.of(context).size.height).round() / 40,
//                               (MediaQuery.of(context).size.width).round() / 30,
//                               (MediaQuery.of(context).size.height).round() / 80,
//                             ),
//                             width: (MediaQuery.of(context).size.width).round() /
//                                 10,
//                             height:
//                                 (MediaQuery.of(context).size.height).round() /
//                                     20,
//                             child: Text(
//                               '승률',
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ],
//                       ),
//                       //KDA 점수----------------------------
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.fromLTRB(
//                               (MediaQuery.of(context).size.width).round() / 10,
//                               (MediaQuery.of(context).size.height).round() / 23,
//                               (MediaQuery.of(context).size.width).round() / 30,
//                               (MediaQuery.of(context).size.height).round() / 70,
//                             ),
//                             width:
//                                 (MediaQuery.of(context).size.width).round() / 7,
//                             height:
//                                 (MediaQuery.of(context).size.height).round() /
//                                     25,
//                             child: Text(
//                               '10 / 2 / 2',
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(
//                               (MediaQuery.of(context).size.width).round() / 9.0,
//                               (MediaQuery.of(context).size.height).round() / 70,
//                               (MediaQuery.of(context).size.width).round() / 30,
//                               (MediaQuery.of(context).size.height).round() / 80,
//                             ),
//                             width: (MediaQuery.of(context).size.width).round() /
//                                 10,
//                             height:
//                                 (MediaQuery.of(context).size.height).round() /
//                                     20,
//                             child: Text(
//                               'KDA',
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             Row(
//               children: <Widget>[
// //파티찾기-----------------------
//                 Container(
//                   margin: EdgeInsets.fromLTRB(
//                     (MediaQuery.of(context).size.width).round() / 7.5,
//                     (MediaQuery.of(context).size.height).round() / 65,
//                     (MediaQuery.of(context).size.width).round() / 30,
//                     (MediaQuery.of(context).size.height).round() / 80,
//                   ),
//                   width: (MediaQuery.of(context).size.width).round() / 3,
//                   height: (MediaQuery.of(context).size.height).round() / 4,
//                   child: RaisedButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                         side: BorderSide(color: Colors.white10)),
//                     onPressed: () {},
//                     color: Colors.yellow,
//                     textColor: Colors.black,
//                     child: Text("파티찾기", style: TextStyle(fontSize: 14)),
//                   ),
//                 ),
// //정보보기-----------------------
//                 Container(
//                   margin: EdgeInsets.fromLTRB(
//                     (MediaQuery.of(context).size.width).round() / 20.0,
//                     (MediaQuery.of(context).size.height).round() / 65,
//                     (MediaQuery.of(context).size.width).round() / 30,
//                     (MediaQuery.of(context).size.height).round() / 80,
//                   ),
//                   width: (MediaQuery.of(context).size.width).round() / 3,
//                   height: (MediaQuery.of(context).size.height).round() / 4,
//                   child: RaisedButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                         side: BorderSide(color: Colors.white10)),
//                     onPressed: () {},
//                     color: Colors.yellow,
//                     textColor: Colors.black,
//                     child: Text(
//                       "정보보기",
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
// //검색창-------------------
//             Container(
//               margin: EdgeInsets.fromLTRB(
//                 (MediaQuery.of(context).size.width).round() / 19.0,
//                 (MediaQuery.of(context).size.height).round() / 25,
//                 (MediaQuery.of(context).size.width).round() / 30,
//                 (MediaQuery.of(context).size.height).round() / 20.0,
//               ),
//               width: (MediaQuery.of(context).size.width).round() / 1.25,
//               height: (MediaQuery.of(context).size.height).round() / 15,
//               child: TextField(
//                 autocorrect: true,
//                 decoration: InputDecoration(
//                   hintText: '소환사 or 챔프 이름',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.yellow, width: 2),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
