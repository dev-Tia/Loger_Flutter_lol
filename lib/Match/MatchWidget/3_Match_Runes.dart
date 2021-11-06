import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import 'package:gaap/Providers/MatchProvider.dart';
import 'package:gaap/Match/MatchData/MatchFunction.dart';

class MatchRunes extends StatelessWidget {
  //for문을 위한 MatchTotal에서 받아온 i
  final int i;
  MatchRunes(this.i);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.01),
      child: Column(
        children: <Widget>[
          runesAImg(context),
          spacing(),
          runesBImg(context),
        ],
      ),
    );
  }

  //첫번째 룬 이미지
  Widget runesAImg(context) {
    final providerMatch = Provider.of<MatchProvider>(context, listen: true);
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.05,
        height: Size.width * 0.05,
        child: runesInfoState
            ? CachedNetworkImage(
                imageUrl: providerMatch.spellA[i],
                errorWidget: (context, url, error) => Icon(Icons.image),
                fit: BoxFit.fill,
              )
            : Container(),
      ),
    );
  }

  //룬 사이 공간
  Widget spacing() {
    return Container(
      height: Size.width * 0.01,
    );
  }

  //두번째 룬 이미지
  Widget runesBImg(context) {
    final providerMatch = Provider.of<MatchProvider>(context, listen: true);
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        child: runesInfoState
            ? CachedNetworkImage(
                imageUrl: providerMatch.spellB[i],
                errorWidget: (context, url, error) => Icon(Icons.image),
                fit: BoxFit.fill,
              )
            : Container(),
      ),
    );
  }
}

//로딩 되지 않았을때 룬 위젯
class MatchRunesLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Size.width * 0.01),
      child: Column(
        children: <Widget>[
          runesAImg(),
          spacing(),
          runesBImg(),
        ],
      ),
    );
  }

  //첫번째 룬 이미지
  Widget runesAImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }

  //룬 사이 공간
  Widget spacing() {
    return Container(
      height: Size.width * 0.01,
    );
  }

  //두번째 룬 이미지
  Widget runesBImg() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: Size.width * 0.045,
        height: Size.width * 0.045,
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
