import 'package:flutter/material.dart';

import 'package:gaap/Match/MatchData/MatchFunction.dart';
import 'package:gaap/Match/MatchWidget/10_Match_Top_Info.dart';
import 'package:gaap/Match/MatchWidget/0_Match_Total.dart';
import 'package:gaap/Match/MatchWidget/11_Match_Vs_Info.dart';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/MatchProvider.dart';

class Match extends StatefulWidget {
  final int gameId;
  final String winState;
  final String queueType;
  final String gameCreation;
  final String gameDuration;
  final String summonerName;
  Match(this.gameId, this.winState, this.queueType, this.gameCreation,
      this.gameDuration, this.summonerName);

  @override
  MatchState createState() => MatchState();
}

class MatchState extends State<Match> {
  bool startLoad = false;
  int gameId;
  String winState;
  String summonerName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!MatchState');
    if (startLoad == false) {
      gameId = widget.gameId;
      winState = widget.winState;
      summonerName = widget.summonerName;
      final providerMatch = Provider.of<MatchProvider>(context, listen: true);
      print('providerMatch.gameId=================${providerMatch.gameId}');
      MatchCall().callgameInfo(context, gameId, summonerName);
      startLoad = true;
    }
    return WillPopScope(
      onWillPop: () {
        MatchCall().reset();
        return Future(() => true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //상단의 승 패 시간 정보
              MatchTopInfo(winState, widget.queueType, widget.gameCreation,
                  widget.gameDuration),

              //검색한 사람이 항상 상단에 오도록 하는 조건
              for (int i = 0; i < 10; i++)
                nameState
                    ? MatchTotal(i, summonerName)
                    : MatchTotal(9 - i, summonerName),

              //토탈 비교
              callgameInfoState ? MatchVsInfo() : MatchVsInfoLoad(),
            ],
          ),
        ),
      ),
    );
  }
}
