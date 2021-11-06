/* import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RedInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "챔피언 공략",
      debugShowCheckedModeBanner: false,
      home: _RedInfo(),
    );
  }
}

class _RedInfo extends StatefulWidget {
  @override
  _RedInfoState createState() => _RedInfoState();
}

class _RedInfoState extends State<_RedInfo>
    with SingleTickerProviderStateMixin {
  //그래프 데이터 --참고용
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

  //상단
  Material topItems(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 7.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.black,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Sparkline(
                      data: data,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //중간 왼쪽 박스
  Material lefttems(String title, String subtitle) {
    return Material(
      color: Color.fromRGBO(27, 59, 102, 1),
      elevation: 7.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.black,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width).round() / 3.8,
                    height: (MediaQuery.of(context).size.height).round() / 6.5,
                    child: Image.asset('images/etc/E_Platinum.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //중간 오른쪽 박스
  Material rightitems(String title, String subtitle) {
    return Material(
      color: Color.fromRGBO(27, 59, 102, 1),
      elevation: 7.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.black,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //하단
  Material bottomItems(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 7.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.black,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Sparkline(
                      data: data1,
                      fillMode: FillMode.below,
                      fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.amber[800], Colors.amber[200]],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        backgroundColor: Color.fromRGBO(76, 207, 176, 1),
        title: Text("챔피언공략"),
        bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.cyan[700],
            tabs: [
              Tab(text: '탑'),
              Tab(text: '정글'),
              Tab(text: '미드'),
              Tab(text: '봇'),
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
          Container(
            color: Color.fromRGBO(18, 34, 47, 1),
            child: StaggeredGridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: topItems("왼손은 흑염룡", "지난기록", "2연승 중"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: lefttems(
                    "랭크",
                    "lp: 32",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: rightitems("총 승률", '48.6'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: rightitems("챔프이름 승률", "25.6%"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bottomItems("평균 KDA", "0.9 / 4.5 / 2.1", "상승중"),
                ),
              ],
              staggeredTiles: [
                StaggeredTile.extent(4, 250.0),
                StaggeredTile.extent(2, 250.0),
                StaggeredTile.extent(2, 120.0),
                StaggeredTile.extent(2, 120.0),
                StaggeredTile.extent(4, 250.0),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(82.5, 20.0, 40.0, 82.5),
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/blue_info.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(82.5, 20.0, 40.0, 82.5),
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/blue_info.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(82.5, 20.0, 40.0, 82.5),
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/blue_info.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(82.5, 20.0, 40.0, 82.5),
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/blue_info.png'),
              ),
            ),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
 */
