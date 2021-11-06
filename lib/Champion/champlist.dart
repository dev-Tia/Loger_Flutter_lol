import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gaap/Champion/champ_recommend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:gaap/Url_List.dart';
import 'dart:io';

//import 'champ_counter.dart';

class Champlist<T> extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState<T> extends State<Champlist<T>>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool loadJsonState = false;
  Future<Map<String, String>> loadJson() async {
    print('loadJson() start');
    final jsonA = await DefaultAssetBundle.of(context)
        .loadString('data_repo/champion_info_list_ko_sorted.json');
    if (fetchVersionState == false) {
      fetchVersion();
    }
    return {'fileA': jsonA};
  }

  var version = '';
  List<String> champlength = [];
  List<String> champimg = [];
  List<String> champEnName = [];
  var _searchEdit = new TextEditingController();
  bool _isSearch = true;
  String _searchText = "";

  List<List<String>> _socialListItems;
  List<String> _searchListItems;
  List<String> _searchListItems1;
  List<String> _searchListItems2;
  //TabController _tabController2;

  bool fetchVersionState = false;
  Future<dynamic> fetchVersion() async {
    print('fetchVersion() Strat');
    http.Response response;
    String body;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        response = await http.get(Url().version);
        body = utf8.decode(response.bodyBytes);
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(body);
          version = jsonData[0];
        } else {
          print('fetchVersion error');
          fetchVersion();
        }
        if (mounted) {
          print('fetchVersionState true');
          fetchVersionState = true;
          if (fetchVersionState == true) {
            champList();
          }
        }
      }
    } catch (e) {
      print('fetchVersion error');
      print('error = $e');
      fetchVersion();
    }
  }

  bool champListState = false;
  Future<dynamic> champList() async {
    print('start champList()');
    http.Response response;
    String body;
    try {
      response = await http.get(KeyPlus().urlkeyPlus(Url().champListUrl));
      body = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(body);
        champlength = List<String>(jsonData.length);
        champimg = List<String>(jsonData.length);
        champEnName = List<String>(jsonData.length);
        for (var i = 0; i < jsonData.length; i++) {
          champlength[i] = (jsonData[i]["name"].toString());
          champimg[i] = (jsonData[i]['imgsrc']);
          champEnName[i] = (jsonData[i]['id'].toString());
          _socialListItems = new List.generate(
              champlength.length, (i) => List(3),
              growable: false);
        }

        for (var i = 0; i < _socialListItems.length; i++) {
          _socialListItems[i][0] = champlength[i];
          _socialListItems[i][1] = champimg[i];
          _socialListItems[i][2] = champEnName[i];
        }

        if (mounted) {
          setState(() {
            print('champListState true');
            champListState = true;
          });
        }
      } else {
        while (response.statusCode == 200) {
          champList();

          break;
        }
      }
    } catch (e) {
      print('champList error');
      Future.delayed(const Duration(seconds: 3), () async {
        champList();
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //_tabController2 = TabController(length: 5, vsync: this);
    super.initState();
  }

  MyAppState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  List data;

  @override
  Widget build(BuildContext context) {
    print('-----------------------ChampList start---------------------------');
    super.build(context);
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.black));
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
/*           appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          title:
             Text(
            "챔피언 리스트",
            style: TextStyle(
                color: Color.fromRGBO(217, 165, 102, 0.9),
                fontWeight: FontWeight.bold),
          ), 
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          bottomOpacity: 1,
          elevation: 10,
        ),  */
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              height: (MediaQuery.of(context).size.height),
              width: (MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  _isSearch ? _listView() : _searchListView(),
                  _searchBox()
                ],
              ),
            )));
  }

  Widget _searchBox() {
    print('_searchBox() start');
    return Column(children: <Widget>[
      Container(
        //decoration: BoxDecoration(border: Border.all(width: 1.0)),
        margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Container(
          //color: Color.fromRGBO(2, 117, 216, 1),
          child: TextField(
            controller: _searchEdit,
            decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.search, color: Color.fromRGBO(2, 6, 89, 1)),
              focusColor: Color.fromRGBO(2, 6, 89, 1),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(2, 6, 89, 1)),
              ),
              /*  hintText: "챔피언 검색",
              hintStyle: new TextStyle(color: Colors.grey[300]), */
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(2, 6, 89, 1)),
          ),
        ),
      ),
      //tabbar
    ]);
  }
  //   var a = (MediaQuery.of(context).size);
/* 
    var tabbar = Container(
      width: a.width,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(242, 226, 5, 1),
      ),
      child: TabBar(
          unselectedLabelColor: Color.fromRGBO(13, 13, 13, 0.5),
          labelColor: Color.fromRGBO(2, 6, 89, 1),
          tabs: [
            Tab(text: '탑'),
            Tab(text: '미드'),
            Tab(text: '정글'),
            Tab(text: '원딜'),
            Tab(text: '서포터')
          ],
          controller: _tabController2,
          indicatorColor: Color.fromRGBO(2, 6, 89, 1),
          indicatorSize: TabBarIndicatorSize.tab),
    ); */

  Widget _listView() {
    print('_listView() start');
    var a = (MediaQuery.of(context).size.height);
    return Flexible(
        child: Center(
      child: FutureBuilder(
          future: loadJson(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              if (champListState == false) {
                //champListState = true;
                return Container(
                    height: (MediaQuery.of(context).size.width) * 0.5,
                    width: (MediaQuery.of(context).size.width) * 0.5,
                    child: Image.asset('images/etc/Crab.v1.gif'));
              }
            }
            var jsondata = json.decode(snapshot.data['fileA']);
            return GridView.builder(
              //padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return champListState == true
                    ? Card(
                        /*   margin: EdgeInsets.fromLTRB(
                          (MediaQuery.of(context).size.width).round() / 200,
                          (MediaQuery.of(context).size.height).round() / 500,
                          (MediaQuery.of(context).size.width).round() / 200,
                          (MediaQuery.of(context).size.height).round() / 500,
                        ), */
                        child: champlength[index] != '스카너'
                            ? GestureDetector(
                                child: Stack(
                                  children: <Widget>[
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black54,
                                              blurRadius: 2.0,
                                              spreadRadius: 2.0,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // border: Border.all(
                                          //   color: Colors.white,
                                          //   width: 1
                                          // ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: Url().ddragon +
                                                version +
                                                '/img/champion/' +
                                                jsondata[index]['imgsrc'],
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.fill,
                                            width: a,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            // decoration: BoxDecoration(
                                            //   color: Colors.green,
                                            //   borderRadius: BorderRadius.only(
                                            //     topLeft: Radius.circular(2.0),
                                            //     topRight: Radius.circular(2.0),
                                            //   )
                                            // ),
                                            color: Colors.transparent,
                                            padding: EdgeInsets.all(3.0),
                                            child: Text(
                                              "${champlength[index]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        30,
                                                backgroundColor: Colors.black54,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChampRecommend(
                                          name: jsondata[index]['id']),
                                    ),
                                  );
                                },
                              )
                            : GestureDetector(
                                child: Stack(
                                  children: <Widget>[
                                    InkWell(
                                      child: CachedNetworkImage(
                                        imageUrl: Url().ddragon +
                                            version +
                                            '/img/champion/' +
                                            jsondata[index]['imgsrc'],
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.fill,
                                        width: a,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.5),
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'R.I.P',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    IntrinsicHeight(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            color: Colors.black45,
                                            padding: EdgeInsets.all(7.0),
                                            child: Text(
                                              "${champlength[index]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width) /
                                                        30,
                                                backgroundColor: Colors.black45,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                    : Container();
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (a / 180).round(), childAspectRatio: 1),
              itemCount: jsondata == null ? 0 : champlength.length,
            );
          }),
    ));
  }

  Widget _searchListView() {
    print('_searchListView() start');
    var item;
    var item1;
    var item2;
    _searchListItems = new List<String>();
    _searchListItems1 = new List<String>();
    _searchListItems2 = new List<String>();

    for (int i = 0; i < _socialListItems.length; i++) {
      item = _socialListItems[i][0];
      item1 = _socialListItems[i][1];
      item2 = _socialListItems[i][2];
      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
        _searchListItems1.add(item1);
        _searchListItems2.add(item2);
      }
    }

    return _searchAddList();
  }

  Widget _searchAddList() {
    var a = (MediaQuery.of(context).size.height);

    return Flexible(
        child: Center(
      child: FutureBuilder(
          future: loadJson(),
          builder: (context, snapshot) {
            if (version == '') {
              return Container(
                  height: a * 0.5,
                  width: a * 0.5,
                  child: Image.asset('images/etc/gif2.gif'));
            }
            var jsondata = json.decode(snapshot.data['fileA']);
            return GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  color: Colors.black,
                  child: GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          child: CachedNetworkImage(
                            imageUrl: Url().ddragon +
                                version +
                                '/img/champion/' +
                                _searchListItems1[index],
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fill,
                            width: a,
                          ),
                        ),
                        IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                color: Colors.black45,
                                padding: EdgeInsets.all(7.0),
                                child: Text(
                                  "${_searchListItems[index]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        (MediaQuery.of(context).size.width) /
                                            30,
                                    backgroundColor: Colors.black45,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChampRecommend(name: _searchListItems2[index]),
                        ),
                      );
                    },
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (a / 180).round(), childAspectRatio: 1),
              itemCount: jsondata == null ? 0 : _searchListItems.length,
            );
          }),
    ));
  }

//https://github.com/vignesh7501/Flutter-SerachView/blob/master/lib/main.dart
}
