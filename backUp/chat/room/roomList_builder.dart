import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:gaap/Extends/multi_type_list_view.dart';
import 'room_data.dart';

class TitleItemBuilder extends MultiTypeWidgetBuilder<String> {

  @override
  Widget buildWidget(BuildContext context, String item, int index) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text("광고창", 
        style: TextStyle(
          fontSize: 20, 
          color: Colors.lightBlue
        ),
      ),
    );
  }
}
class GroupMessageItemBuilder extends MultiTypeWidgetBuilder<GroupMessage> {
  final ScrollController controller;
  final OnItemTap<Message> onItemTap;

  GroupMessageItemBuilder({this.controller, this.onItemTap});

  @override
  Widget buildWidget(BuildContext context, GroupMessage item, int index) {
    if(item == null || item.messages == null || item.messages.isEmpty) 
    return null;
    return Container(
      height: 100,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: item.messages.length,
        itemBuilder: (context, index){
          if(item.messages == null || item.messages.length < index) 
            return Offstage();
          var message = item.messages[index];
          return InkWell(
            onTap: () {
               onItemTap(context, message, index);
            },
            child: Container(
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[BoxShadow(
                    color:Colors.black87, 
                    blurRadius: 3,)
                  ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(message.profile, 
                  fit: BoxFit.cover, 
                  width: 80, 
                  height: 80,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}

typedef OnItemTap<T> = void Function(BuildContext context, T item, int index);

class MessageBuilder extends MultiTypeWidgetBuilder<Message> {

  final OnItemTap<Message> onItemTap;

  MessageBuilder(this.onItemTap);

  @override
  Widget buildWidget(BuildContext context, Message item, int index) {
    return Container(
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button for close dialog!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('초대하기'),
                content: const Text('소환사를 초대 하시겠습니까?'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: const Text('초대하기'),
                    onPressed: () {
                      onItemTap(context, item, index);
                    },
                  ),
                ],
              );
            }
          );
        },
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color:Colors.black45, 
                blurRadius: 3,
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              item.profile, 
              fit: BoxFit.cover, 
              width: 60, 
              height: 60,
            ),
          ),
        ),
        title: Text(item.summoner),
        subtitle: Text(item.rank  + '\n' + item.roomName),
        trailing: Text(formatDate(
        item.time, [HH, '시', mm, '분', ss, '초',]
        )),
      ),
    );
  }
}

