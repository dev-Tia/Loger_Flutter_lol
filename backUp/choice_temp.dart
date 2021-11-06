// import 'package:flutter/material.dart';
// import 'package:gaap/MainScreen.dart';


// class ChoiceTemp extends StatefulWidget {
//   @override
//   State createState() => _ChoiceTempState();
// }

// class _ChoiceTempState extends State<ChoiceTemp> {

//   String text = '';
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('소환사 선택'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             child: RaisedButton(
//               child: Text('소환사 : ' + text),
//               onPressed: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SecondRoute(str: List<String>.generate(3, (i) => " $i"))),
//                 );
//                 setState(() {
//                   text = result;
//                 });
//               },
//             ),
//           ),
//           Container(
//             child: RaisedButton(
//               child: Text('선택완료'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MainScreen()),
//                 );
//               },
//             ),
//           ),
//         ]
//       ),
//     );
//   }
// }
// class SecondRoute extends StatelessWidget {

//   final List<String> str;
//   SecondRoute({Key key, @required this.str}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('지후니'),
//       ),
//       body: Center(
//         child: Container(
//           child:ListView.builder(
//             itemCount: str.length,
//             itemBuilder: (context, index){
//               return ListTile(
//                 title: Text('소환사 선택 :'+'${str[index]}'),
//                 onTap: () {
//                   Navigator.pop(context,'소환사 : ${str[index]}');
//                 }
//               );
//             }
//           ),
//         ),
//       ),
//     ); 
//   }
// }


