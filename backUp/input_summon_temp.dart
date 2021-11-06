// import 'package:flutter/material.dart';
// import 'package:gaap/MainScreen.dart';


// class InputSummoner extends StatefulWidget {
//   @override
//   _InputSummonerState createState() => _InputSummonerState();
// }

// class _InputSummonerState extends State<InputSummoner> {
 
//   final myController = TextEditingController();

//   @override
//   void dispose() {
   
//     myController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('소환사 입력 역시 맨 처음 한번만'),
//       ),
//       backgroundColor: Color.fromRGBO(18 , 34, 47, 1),
//       body: Center(
//         child: Column(
//           children:[            
//             //방제적기//
            
//             Container(
              
//               margin: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
//               child: Text('소환사 이름 적어주세요',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
            
//             Container(
//               width: 270,
//               height: 40,
//               margin: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 30.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: '방제목 적기',
//                 ),
//                 autofocus: true,
//               ),
//             ),

//             Container(
//               child: FloatingActionButton(
//                 onPressed: () {
//                   return showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         content: Text(myController.text + " 가 맞습니까?"),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: new Text("아니"),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                           FlatButton(
//                             child: new Text("응"),
//                             onPressed: () {
//                               Navigator.push( context, 
//                                 MaterialPageRoute(builder: (context) => MainScreen()),
//                               );
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 tooltip: 'ㅇ',
//                 child: Icon(Icons.text_fields),
//               ),
//             ),

//           ]
//         ),
//       ), 
//     );
//   }
// }