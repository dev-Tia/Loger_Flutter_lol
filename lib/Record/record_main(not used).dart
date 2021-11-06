// import 'package:flutter/material.dart';
// import 'package:gaap/Record/champlist.dart';
// import 'package:gaap/Record/input_summon.dart';



// class RecordMainP extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('기록보기 메인'),
//           backgroundColor: Colors.cyan[600],
//         ),
//         backgroundColor: Colors.black87,
//         body: Center(
//           child: Column(
//             children:[
//               //방제적기//
//               Container(
//                 width: 260,
//                 height: 40,
//                 margin: EdgeInsets.fromLTRB(10.0, 310.0, 10.0, 10.0),
//                 child: RaisedButton(
//                   onPressed: () {
//                     Navigator.push( context,
//                       MaterialPageRoute(builder: (context) => InputSummonerInfo()),
//                     );
//                   },
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   child: Text('소환사 정보 보기', 
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   textColor: Colors.white,
//                   splashColor: Colors.red,
//                   color: Colors.orange[600],
//                 ),
//               ),

//             Container(
//                 width: 260,
//                 height: 40,
//                 margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
//                 child: RaisedButton(
//                   onPressed: () {
//                     Navigator.push( context,
//                       MaterialPageRoute(builder: (context) => Champlist()),
//                     );
//                   },
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   child: Text('챔피언 정보 보기', 
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   textColor: Colors.white,
//                   splashColor: Colors.red,
//                   color: Colors.orange[600],
//                 ),
//               ),


//             ]
//           ),
//         ),
//       ),
//     );
//   }
// }
