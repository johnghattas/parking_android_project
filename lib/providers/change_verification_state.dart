import 'package:flutter/cupertino.dart';

enum VerificationState { VERIFIED, NONE_VERIFIED, VERIFYING, WRONG }

class ChangeVerificationState extends ChangeNotifier {

  VerificationState status = VerificationState.NONE_VERIFIED;
  String verificationId;

  int lastIndex = 6;
  List<int> digits = List(6);

  bool isFullDigit = false;

  setStatus(VerificationState state) {
    this.status = state;
    notifyListeners();
  }


  addDigit(int digit, int index) {
    print(digits.length);

    digits[index] = digit;

    bool _isEmpty = false;

    for(int i = 0; i < lastIndex; i++) {
      if(digits[i] == null) {
        _isEmpty = true;
      }
    }
    if(!_isEmpty) {
      isFullDigit = true;
      print('done');

      notifyListeners();
    }
  }
}