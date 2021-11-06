import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:provider/provider.dart';
import 'package:gaap/Providers/CheckProvider.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'firebase', 'admob'],
    testDevices: <String>[],
  );
  final _nativeAdController = NativeAdmobController();

  BannerAd _bannerAd;
  NativeAd _nativeAd;
  InterstitialAd _interstitialAd;
  //int _coins = 0;
  int i = 0;
  int j = 5;
  int k = 0;
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  NativeAd createNativeAd() {
    return NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'adFactoryExample',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("$NativeAd event $event");
      },
    );
  }

  @override
  void initState() {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
    super.initState();

    FirebaseAdMob.instance.initialize(appId: providerCheckOS.getadUnitID);
    print('_bannerAd 시작!!!');

    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show();

    /* _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
    _interstitialAd?.show(); */

    /*    RewardedVideoAd.instance.load(
         adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);

    _nativeAd ??= createNativeAd(); */
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _nativeAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //RewardedVideoAd.instance.show();

    /* _nativeAd
      ..load()
      ..show(
        anchorType: Platform.isAndroid ? AnchorType.bottom : AnchorType.top,
      );
    */
    
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
      child: Container(
        child: (Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    color: Colors.amber,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                // color: Colors.red,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width ,
                child: WebView(
                  initialUrl: 'https://real-xvimd.run.goorm.io/real/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
              for (i = 0; i < j; i++) con2()
            ],
          ),
        )),
      ),
    )));
  }

  bool adState = false;

  Widget ad() {
    final providerCheckOS = Provider.of<CheckProvider>(context, listen: false);
    count(i);
    var m = MediaQuery.of(context).size;
    return Card(
      shadowColor: Color.fromRGBO(2, 6, 89, 1),
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.yellow[600], width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.fromLTRB(
        (m.width).round() / 20,
        0,
        (m.width).round() / 20,
        (m.height).round() / 70,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: 100,
        //width: 200,
        child: NativeAdmob(
          adUnitID: providerCheckOS.getadUnitID,
          controller: _nativeAdController,
          type: NativeAdmobType.banner,
        ),
      ),
    );
  }

  Widget con() {
    k = k + 1;
    if (i == 2) {
      return ad();
    } else if (i == 3) {
      k = k - 1;
      return Container(height: 50, child: Text('$k'));
    } else {
      return Container(height: 50, child: Text('$k'));
    }
  }

  Widget con2() {
    return i == 2
        ? Column(
            children: <Widget>[
              ad(),
              Container(
                height: 50,
                child: Text('$i'),
              ),
            ],
          )
        : Container(
            height: 50,
            child: Text('$i'),
          );
  }

  count(i) {
    adState = true;
    j += 1;
  }
}
/*  NativeAdmobBannerView(
            adUnitID: 'ca-app-pub-3940256099942544/2247696110',
            showMedia: true,
            style: BannerStyle.light,
            contentPadding: EdgeInsets.all(10),
          ), */
