import 'package:flutter/material.dart';
import 'package:gaap/Champion/champlist.dart';
import 'package:gaap/In_Playing/inPlayTest2.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:gaap/Summoner/summon_record.dart';
import 'package:gaap/Board/Board_main.dart';
import 'package:provider/provider.dart';

import 'package:gaap/Board/board_Update.dart';
import 'package:gaap/Login/Google/Google_Login2.dart';
import 'package:gaap/PassAuth.dart';
import 'package:gaap/Providers/SummerProvider.dart';
import 'package:gaap/Url_List.dart';

class MyUtility {
  BuildContext context;
  MyUtility(this.context) : assert(context != null);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 1;

/* MapTemp(), */
  final List<Widget> _children = [
    //Inplay(),
    Test(),
    SummonerRec(),
    Champlist(),
    Board()
  ];

  PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      drawer: drawer(),
      body: Stack(
        children: <Widget>[
          PageView(
              controller: pageController,
              onPageChanged: _onTap,
              children: _children,
              physics: NeverScrollableScrollPhysics()),
          Builder(
            builder: (context) {
              return Positioned(
                width: 50,
                height: 50,
                bottom: _currentIndex == 2 ? 60 : 30,
                left: 10,
                child: FloatingActionButton(
                  backgroundColor: Color.fromRGBO(2, 6, 89, 0.7),
                  onPressed: () {},
                  child: IconButton(
                    icon: new Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                      /* _toStart(); */
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     topLeft:Radius.circular(40),
          //     topRight: Radius.circular(40)
          // ),
          border: Border.all(color: Colors.white54, width: 1),
          color: Colors.white60,
        ),
        child: SizedBox(
          child: btmNavBar(),
        ),
      ),
    );
  }

  ClipRRect btmNavBar() {
    return ClipRRect(
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(45),
        //   topRight: Radius.circular(45),
        // ),

        child: BottomNavigationBar(
            showSelectedLabels: true,
            elevation: 5,
            backgroundColor: Color.fromRGBO(2, 6, 89, 0.8),
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            // iconSize: 35,
            selectedItemColor: Color.fromRGBO(242, 226, 5, 1),
            unselectedItemColor: Color.fromRGBO(242, 226, 5, 0.35),
            currentIndex: _currentIndex,
            items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text('인게임정보'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('메인으로'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            title: Text('챔피언정보'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('게시판'),
          )
        ]));
  }

  Widget riotText() {
    return Container(
      width: M(context).width * 0.55,
      height: /* M(context).width */ 60,
      color: Colors.amber[100],
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "RIOT 정책",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Icon(Icons
                .notification_important), /* assignment_late  brightness_high */
          ],
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'RIOT 정책',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                    child: new Text(
                  "[GAAP] isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing Riot Games properties. Riot Games, and all associated properties are trademarks or registered trademarks of Riot Games, Inc.",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                )),
              );
            },
          );
        },
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: M(context).width * 0.55,
      height: /* M(context).width */ 60,
      color: Colors.amber,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "로그아웃",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.directions_run), /* assignment_late */
          ],
        ),
        onPressed: () {
          GoogleLogin2().googleLogOut(context).then((value) =>
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PassAuth()),
                  (Route<dynamic> route) => false));
        },
      ),
    );
  }

  Widget drawerHeader() {
    final providerSummonerName =
        Provider.of<SummerProvider>(context, listen: false);
    return DrawerHeader(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                //margin: EdgeInsets.all(MyUtility(context).width / 30),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(MyUtility(context).width / 100),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        color: Color.fromRGBO(242, 226, 5, 1),
                        child: CachedNetworkImage(
                          imageUrl: Url().ddragon +
                              version +
                              '/img/profileicon/' +
                              providerSummonerName.summerIcon +
                              '.png',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(242, 242, 242, 1),
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(242, 226, 5, 1))),
                          errorWidget: (context, url, error) => Container(
                            width: (MediaQuery.of(context).size.width) * 0.3,
                            height: (MediaQuery.of(context).size.width) * 0.3,
                            color: Color.fromRGBO(242, 226, 5, 1),
                          ),
                          fit: BoxFit.fill,
                          width: (MediaQuery.of(context).size.width) * 0.3,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(2, 6, 89, 1),
                        border: Border.all(
                            color: Color.fromRGBO(242, 226, 5, 1),
                            width: MyUtility(context).width / 160),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.fromLTRB(
                          MyUtility(context).width / 80,
                          MyUtility(context).width / 160,
                          MyUtility(context).width / 80,
                          MyUtility(context).width / 160),
                      child: Text(
                        providerSummonerName.summerLevel,
                        style: TextStyle(
                            color: Color.fromRGBO(242, 226, 5, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: MyUtility(context).width / 30),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                /* margin: EdgeInsets.only(
                              bottom: MyUtility(context).height * 0.03), */
                child: Text(
                  providerSummonerName.summerName,
                  style: TextStyle(
                    color: Color.fromRGBO(242, 226, 5, 1),
                  ),
                ),
              ),
            ],
          )),
      decoration: BoxDecoration(
        color: Color.fromRGBO(2, 6, 89, 1),
      ),
    );
  }

  Widget drawer() {
    return Container(
      width: M(context).width * 0.55,
      child: Drawer(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: M(context).height,
          child: Column(
            children: <Widget>[
              // 드로워해더 추가
              drawerHeader(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // 창이 왼쪽에서 튀어나오면서 점점커질때 부모 width값이 바뀌기 떄문에 에러발생
                    // 다 열린뒤에 불러오거나 쓰지않는 쪽으로 가야함
                    // Expanded(
                    //   flex: 1,
                    //   child: LiquidLinearProgressIndicator(
                    //       direction: Axis.vertical,
                    //       backgroundColor: Colors.white,
                    //       value: 0.8,
                    //       valueColor: new AlwaysStoppedAnimation<Color>(
                    //         Color.fromRGBO(128, 214, 250, 1),
                    //       )),
                    // ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Item 1'),
                          onTap: () {
                            // 네이게이터 팝을 통해 드로워를 닫는다.
                            Navigator.pop(context);
                          },
                        ),
                        // 리스트타일 추가
                        ListTile(
                          title: Text('Item 2'),
                          onTap: () {
                            // 드로워를 닫음
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Container(
                            height: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              riotText(),
              logoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
