import 'package:flutter/widgets.dart';

class BoardProvider with ChangeNotifier {
  bool boardC;
  bool boardCheck() => boardC;

  BoardProvider(this.boardC);

  void boardCheckT() {
    boardC = true;
    notifyListeners(); //must be inserted
  }

  void boardCheckF() {
    boardC = false;
    //notifyListeners(); //must be inserted
  }
}
