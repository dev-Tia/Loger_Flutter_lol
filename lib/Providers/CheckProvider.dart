import 'package:flutter/widgets.dart';

class CheckProvider with ChangeNotifier {
  String _adUnitID;
  String checkTextValue;
  String _platform;

  get getadUnitID => _adUnitID;
  get getplatform => _platform;

  CheckProvider();

  void inputPlatform(platform, mode) {

    _platform = platform;

    String debugAndroidAdUnitID = 'ca-app-pub-3940256099942544/2247696110';
    String debugIOSAdUnitID = 'ca-app-pub-3940256099942544/3986624511';

    String releaseAndroidAdUnitID = 'ca-app-pub-6984881740253042/2662833615';
    String releaseIOSAdUnitID = 'ca-app-pub-6984881740253042/1896546857';

    if (mode == 'debug') {
      checkTextValue = 'debug---';

      if (platform == 'Android') {
        checkTextValue += 'Android';
        _adUnitID = debugAndroidAdUnitID;
      }
      if (platform == 'IOS') {
        checkTextValue += 'IOS';
        _adUnitID = debugIOSAdUnitID;
      }
    } else if (mode == 'release') {
      checkTextValue = 'release---';

      if (platform == 'Android') {
        checkTextValue += 'Android';
        _adUnitID = releaseAndroidAdUnitID;
      }
      if (platform == 'IOS') {
        checkTextValue += 'IOS';
        _adUnitID = releaseIOSAdUnitID;
      }
    }

    print('_adUnitID------------------- $_adUnitID');
    print('checkTextValue------------------- $checkTextValue');
    // notifyListeners();
  }
}
