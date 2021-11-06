import 'package:flutter/widgets.dart';

class MatchProvider with ChangeNotifier {
  int _gameId;
  get gameId => _gameId;

  List<String> _sendName = List<String>(10);
  get sendName => _sendName;

  List<String> _champUrl = List<String>(10);
  get champUrl => _champUrl;

  List<String> _spellA = List<String>(10);
  get spellA => _spellA;

  List<String> _spellB = List<String>(10);
  get spellB => _spellB;

  List<List> _item = List<List>(10);
  get item => _item;

  MatchProvider(_gameId, _sendName, _champUrl, _spellA, _spellB, _item);

  void inputgameId(gameId) {
    _gameId = gameId;
    notifyListeners();
  }

  void inputsendName(int i, sendName) {
    _sendName[i] = sendName;
    notifyListeners();
  }

  void inputgameUrl(int i, champUrl) {
    _champUrl[i] = champUrl;
    notifyListeners();
  }

  void inputspellA(int i, spellA) {
    _spellA[i] = spellA;
    notifyListeners();
  }

  void inputspellB(int i, spellB) {
    _spellB[i] = spellB;
    notifyListeners();
  }

  void inputItem(int i, item) {
    _item[i] = item;
    notifyListeners();
  }

  void reset() {
    _gameId = null;
    _champUrl = null;
    _spellA = null;
    _spellB = null;
    notifyListeners();
  }
}
