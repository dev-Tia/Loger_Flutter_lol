import 'package:flutter/material.dart';
import 'dart:ui';
import 'blue_info_top.dart';

class BlueInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _BlueInfo(),
    );
  }
}

class _BlueInfo extends StatefulWidget {
  @override
  _BlueInfoState createState() => _BlueInfoState();
}

class _BlueInfoState extends State<_BlueInfo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        title: Text("챔피언공략"),
        bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(text: '탑'),
              Tab(text: '정글'),
              Tab(text: '미드'),
              Tab(text: '원딜'),
              Tab(text: '서포터'),
            ],
            controller: _tabController,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.tab),
        bottomOpacity: 1,
      ),
      backgroundColor: Color.fromRGBO(18, 34, 47, 1),
      body: TabBarView(
        children: [
          //탑
          BlueTop(),
          BlueTop(), 
          BlueTop(), 
          BlueTop(), 
          BlueTop(),
        ],
        controller: _tabController,
      ),
    );
  }
}
