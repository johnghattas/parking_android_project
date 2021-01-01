import 'package:flutter/cupertino.dart';

class ChangeIndex extends ChangeNotifier {
  int pageIndex = 0;
  int _pageCount;

  bool isStopped;

  ChangeIndex([this._pageCount = 3]);

  changePage(int page) {
    pageIndex = page;
    notifyListeners();
  }

  incrementPage() {
    pageIndex++;
    if (pageIndex == _pageCount) {
      pageIndex = 0;
    }
    notifyListeners();
  }

  changeStopped(bool value) {
    isStopped = value;
    notifyListeners();
  }
}
