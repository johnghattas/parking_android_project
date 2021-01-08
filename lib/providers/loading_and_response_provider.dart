import 'package:flutter/cupertino.dart';

enum LoadingErrorState { NONE, LOADING, DONE, ERROR, WORKING }

class LoadingAndErrorProvider extends ChangeNotifier {
  LoadingErrorState state = LoadingErrorState.NONE;

  String error;

  changeState(LoadingErrorState state) {
    this.state = state;
    notifyListeners();
  }

  setError(String message) {
    this.error = message;
    state = LoadingErrorState.ERROR;
    notifyListeners();
  }

  setErrorWithoutNotify(String message,
      [LoadingErrorState state = LoadingErrorState.ERROR]) {
    this.error = message;
    state = state;
  }

  reset() {
    error = null;
    state = LoadingErrorState.NONE;
    notifyListeners();
  }
}
