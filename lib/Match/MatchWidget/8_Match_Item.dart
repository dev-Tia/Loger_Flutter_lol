import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import 'package:gaap/Providers/MatchProvider.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchItem extends StatelessWidget {
  final int i;
  MatchItem(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.3),
      child: Container(
        color: Colors.white.withOpacity(0.6),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              for (int j = 0; j < 6; j++) callItem(i, j, context),
              callAccs(i),
            ]),
          ],
        ),
      ),
    );
  }

  //아이템
  Widget callItem(int i, int j, context) {
    final providerMatch = Provider.of<MatchProvider>(context, listen: true);
    return providerMatch.item[i][j] != '0'
        ? Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: providerMatch.item[i][j],
                errorWidget: (context, url, error) => Icon(Icons.texture),
                fit: BoxFit.fill,
                width: Size.width * 0.045,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                width: Size.width * 0.045,
                height: Size.width * 0.045,
              ),
            ),
          );
  }

  //악세
  Widget callAccs(int i) {
    return accs[i] != '0'
        ? Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: accs[i],
                errorWidget: (context, url, error) => Icon(Icons.image),
                fit: BoxFit.fill,
                width: Size.width * 0.045,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                width: Size.width * 0.045,
                height: Size.width * 0.045,
              ),
            ),
          );
  }
}

//로딩 되지 않았을 때 아이템 위젯
class MatchItemLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        color: Colors.white.withOpacity(0.6),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              for (int j = 0; j < 6; j++) callItem(),
              callAccs(),
            ]),
          ],
        ),
      ),
    );
  }

  Widget callItem() {
    return Container(
      padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          width: Size.width * 0.045,
          height: Size.width * 0.045,
        ),
      ),
    );
  }

  Widget callAccs() {
    return Container(
      padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          width: Size.width * 0.045,
          height: Size.width * 0.045,
        ),
      ),
    );
  }
}
