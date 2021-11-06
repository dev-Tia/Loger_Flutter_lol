import 'package:flutter/widgets.dart';

class SummerProvider with ChangeNotifier {
  String _uid;
  get uid => _uid;

  String _summerName;
  get summerName => _summerName;

  String _summerIcon;
  get summerIcon => _summerIcon;

  String _summerLevel;
  get summerLevel => _summerLevel;

  SummerProvider(_uid, _summerName, _summerIcon, _summerLevel);

  void inputUid(uid) {
    _uid = uid;
    notifyListeners();
  }

  void inputSummerName(name) {
    _summerName = name;
    notifyListeners();
  }

  void inputSummerIcon(icon) {
    _summerIcon = icon;
    notifyListeners();
  }

  void inputSummerLevel(level) {
    _summerLevel = level;
    notifyListeners();
  }

  void reset() {
    _uid = null;
    _summerName = null;
    _summerIcon = null;
    _summerLevel = null;
    notifyListeners();
  }
}
