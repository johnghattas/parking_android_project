import 'package:flutter/cupertino.dart';

enum VerificationState { VERIFIED, NONE_VERIFIED, VERIFYING, WRONG }

class ChangeVerificationState extends ChangeNotifier {

  VerificationState status = VerificationState.NONE_VERIFIED;
  String? verificationId;
  String? error;

  int lastIndex = 6;
  List<int?> digits = List.filled(6, null, growable: false);

  bool isFullDigit = false;
  bool? isAdmin = false;

  setStatus(VerificationState state) {
    this.status = state;
    notifyListeners();
  }

  changeAdmin(bool? isAdmin){
    this.isAdmin = isAdmin;
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

  setError(String? message) {
    this.error = message;
    this.status = VerificationState.NONE_VERIFIED;

    notifyListeners();
  }
}
