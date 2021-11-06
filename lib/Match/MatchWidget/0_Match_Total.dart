import 'package:flutter/material.dart';

import 'package:gaap/Match/MatchData/MatchFunction.dart';
import 'package:gaap/Match/MatchWidget/1_Match_ImgLv.dart';
import 'package:gaap/Match/MatchWidget/3_Match_Runes.dart';
import 'package:gaap/Match/MatchWidget/2_Match_Spells.dart';
import 'package:gaap/Match/MatchWidget/4_Match_TNK.dart';
import 'package:gaap/Match/MatchWidget/7_Match_Item_Etc.dart';

class MatchTotal extends StatelessWidget {
  //for문을 위한 Summoner_Match에서 받아온 i
  final int i;
  final String summonerName;
  MatchTotal(this.i, this.summonerName);

  @override
  Widget build(BuildContext context) {
    Size().init(context);

    return Container(
      //json data상에서 0~4 blue, 5~9 red 팀
      color: !callgameInfoState
          ? Colors.blueGrey[50]
          : summonerName == summonName[i]
              ? Colors.amber[100]
              : i > 4 ? Colors.red[50] : Colors.blue[50],
      child: Container(
        padding:
            EdgeInsets.fromLTRB(0, Size.height * 0.003, 0, Size.height * 0.003),
        width: Size.width,
        child: Row(
          children: <Widget>[
            callgameInfoState ? MatchImgLv(i) : MatchImgLvLoad(),
            callgameInfoState ? MatchSpells(i) : MatchSpellsLoad(),
            callgameInfoState ? MatchRunes(i) : MatchRunesLoad(),
            callgameInfoState ? MatchTNK(i) : MatchTNKLoad(),
            Expanded(
              child: Container(),
            ),
            callgameInfoState ? MatchItemEtc(i) : MatchItemEtcLoad(),
          ],
        ),
      ),
    );
  }
}
