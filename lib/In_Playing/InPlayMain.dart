import 'package:flutter/material.dart';

//========= I N D E X =========================================== 
// ** 모든건 Left(L) 기준, 오른쪽은 함수명 끝에 (R) 붙이면 됨. **

// 구글 광고 = googleAds(),
// 맨 위 한칸 (L+R) = inPlayChampInfo(),
// 챔프 상성 승률 3형제 텍스트 = chmpDefeatRateText(), 
//                  chmpTotalWinRateText(), 
//                  chmpPositionRateText(),

// 챔프 사진 왼쪽 = chmpImgL(),
// 소환사 총 승률 = smmnWinRateL(),
// 소환사 랭크 = smmnRankL(),

// 챔프 상성 승률 3형제 = deFeatRateL(),
//  ㄴ 챔프 상성 승률 = chmpDefeatRate(),
//  ㄴ 총 승률 = chmpTotalWinRate(),
//  ㄴ 포지션 승률 = chmpPositionRate(),

// RedBar = redBar(),
// BlueBar = Bar(),
//=======================================================================  



class InplayMain extends StatefulWidget {
  InplayMain({Key key}) : super(key: key);

  @override
  _InplayMainState createState() => _InplayMainState();
}

class _InplayMainState extends State<InplayMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          googleAds(),
          inPlayChampInfo(),
          inPlayChampInfo(),
          inPlayChampInfo(),
          inPlayChampInfo(),
          inPlayChampInfo(),
         ],
      ),
    );
  }

//구글 광고 쟁이 ================================================================================================
  Widget googleAds(){
    return Container(
      child: Text('저는 상단 광고 입니다.',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          ),
        
        ),
      margin: EdgeInsets.fromLTRB(
        0,
        (MediaQuery.of(context).size.height).round() / 30,
        0,
        (MediaQuery.of(context).size.height).round() / 100,
      ),
      width: (MediaQuery.of(context).size.width).round() / 0.9,
      height: (MediaQuery.of(context).size.width).round() / 5.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(
          color: Colors.blue[600], 
          width: 2
        ),
      ),
    );
  }
//================================================================================================

//본체 한칸 (R+L) ================================================================================================
  Widget inPlayChampInfo(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              inPlaychampinfoL(),
              inPlayChampInfoDefault(),
              inPlaychampinfoR()
            ]
          ),
          Row(
            children: <Widget>[
              redBar(),
              versus(),
              blueBar(),
            ],
          ),
        ],
      ),  
    );
  }
//================================================================================================

//왼쪽 챔프 한 칸 ============================================================================================
  Widget inPlaychampinfoL(){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.red[400], 
          width: 1.5
        
          ),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            chmpImgL(),
            Column(
              children: <Widget>[
                smmnWinRateL(),
                smmnRankL(),
              ],
            ),
            deFeatRateL(),
          ],
        )
      ),
    );
  }

//오른쪽 챔프 한 칸 ============================================================================================
  Widget inPlaychampinfoR(){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.blue[300], 
          width: 1.5
        
          ),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            deFeatRateR(),
            Column(
              children: <Widget>[
                smmnWinRateR(),
                smmnRankL(),
              ],
            ),
            chmpImgR(),
          ],
        ),
      ),
    );
  }



//변치않는 (챔프상성승률, 총승률, 포지션승률) 텍스트 3형제 =================================
  Widget inPlayChampInfoDefault(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 40,
      (MediaQuery.of(context).size.height).round() / 45,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      ),
      child: Column(
        children: <Widget>[
          chmpDefeatRateText(),
          chmpTotalWinRateText(),
          chmpPositionRateText()
        ],
      ),
    );
  }

  Widget chmpDefeatRateText(){
    return Container(
      child: Text('챔프 상성 승률',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),
      )
    );
  }

  Widget chmpTotalWinRateText(){
    return Container(
      child: Text('총 승률',
       style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),
      )
    );
  }
  
  Widget chmpPositionRateText(){
    return Container(
      child: Text('포지션 승률',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),
      )
    );
  }
//================================================================================================

//챔프 이미지 왼쪽 ============================================================================================
  Widget chmpImgL(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 50,
      (MediaQuery.of(context).size.height).round() / 80,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      ),
      width: (MediaQuery.of(context).size.width).round() / 8,
      height: (MediaQuery.of(context).size.width).round() / 8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.yellow[600], width: 1),
        image: DecorationImage(
          image: AssetImage(
              'images/api_source/champion_square/Annie.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

//챔프 이미지 오른쪽 ============================================================================================
  Widget chmpImgR(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 60,
      (MediaQuery.of(context).size.height).round() / 80,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      ),
      width: (MediaQuery.of(context).size.width).round() / 8,
      height: (MediaQuery.of(context).size.width).round() / 8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.yellow[600], width: 1),
        image: DecorationImage(
          image: AssetImage(
              'images/api_source/champion_square/Annie.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

//소환사 승률 왼쪽 ============================================================================================
  Widget smmnWinRateL(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 30,
      (MediaQuery.of(context).size.height).round() / 50,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      ),
      child: Text('55%',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      )
    );
  }

//소환사 승률 오른쪽 ============================================================================================
  Widget smmnWinRateR(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 30,
      (MediaQuery.of(context).size.height).round() / 50,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      ),
      child: Text('55%',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      )
    );
  }
//==============================================================================================================

//소환사 랭크 왼쪽 ============================================================================================
  Widget smmnRankL(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 60,
        (MediaQuery.of(context).size.height).round() / 200,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 180,
      ),
      width: (MediaQuery.of(context).size.width).round() /15,
      height: (MediaQuery.of(context).size.height).round() /25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/etc/E_Diamond.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

//소환사 랭크 오른쪽 ============================================================================================
  Widget smmnRankR(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 50,
        (MediaQuery.of(context).size.height).round() / 200,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 200,
      ),
      width: (MediaQuery.of(context).size.width).round() /15,
      height: (MediaQuery.of(context).size.height).round() /25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/etc/E_Diamond.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
//==============================================================================================================

//승률 삼형제 왼쪽 ========================================================================================== 
  Widget deFeatRateL(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 55,
        (MediaQuery.of(context).size.height).round() / 70,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 180,
      ),
      child:Column(
        children: <Widget>[
          chmpDefeatRate(),
          chmpTotalWinRate(),
          chmpPositionRate(),
        ],
      ),
    );
  }

//승률 삼형제 오른쪽 ==========================================================================================
  Widget deFeatRateR(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 55,
        (MediaQuery.of(context).size.height).round() / 70,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 300,
      ),
      child:Column(
        children: <Widget>[
          chmpDefeatRate(),
          chmpTotalWinRate(),
          chmpPositionRate(),
        ],
      ),
    );
  }
//====================================================================================================================== 

//챔프 상성 승률 ========================================================================================== 
  Widget chmpDefeatRate(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 50,
        (MediaQuery.of(context).size.height).round() / 70,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 180,
      ),
      child: Text('55%',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 12
        ),
      )
    );
  }

//챔프 총 승률 ========================================================================================== 
  Widget chmpTotalWinRate(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 50,
        (MediaQuery.of(context).size.height).round() / 200,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 180,
      ),
      child: Text('45%',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 12
        ),
      )
    );
  }

//챔프 총 승률 ========================================================================================== 
  Widget chmpPositionRate(){
    return Container(
      margin: EdgeInsets.fromLTRB(
        (MediaQuery.of(context).size.width).round() / 50,
        (MediaQuery.of(context).size.height).round() / 200,
        (MediaQuery.of(context).size.width).round() / 200,
        (MediaQuery.of(context).size.height).round() / 200,
      ),
      child: Text('55%',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 12
        ),
      )
    );
  }  

//redBar ========================================================================================== 
  Widget redBar(){
    return Container(
     margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 60,
      (MediaQuery.of(context).size.height).round() / 150,
      (MediaQuery.of(context).size.width).round() / 250,
      (MediaQuery.of(context).size.height).round() / 40,
      ),
      width: (MediaQuery.of(context).size.width).round() / 2.2,
      height: (MediaQuery.of(context).size.width).round() / 30,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.black, width: 1),
        image: DecorationImage(
          image: AssetImage(
              'images/etc/redBar.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget versus(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 40,
      ),
      width: (MediaQuery.of(context).size.width).round() / 25,
      height: (MediaQuery.of(context).size.width).round() / 25,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.black, width: 1),
        image: DecorationImage(
          image: AssetImage(
              'images/etc/vs.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
//blueBar ========================================================================================== 
   Widget blueBar(){
    return Container(
      margin: EdgeInsets.fromLTRB(
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 150,
      (MediaQuery.of(context).size.width).round() / 200,
      (MediaQuery.of(context).size.height).round() / 40,
      ),
      width: (MediaQuery.of(context).size.width).round() / 2.2,
      height: (MediaQuery.of(context).size.width).round() / 30,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(color: Colors.black, width: 1),
        image: DecorationImage(
          image: AssetImage(
              'images/etc/blueBar.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

//========================================================================================== 

}