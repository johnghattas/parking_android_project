import 'dart:async';
import 'package:flutter/material.dart';

class KeyboardChangeBlock {
  StreamController _streamController;


  StreamSink<double> get _chuckListSink =>
      _streamController.sink;

  Stream<double> get chuckListStream =>
      _streamController.stream;


  KeyboardChangeBlock() {
    _streamController = StreamController<double>();
    _chuckListSink.add(0);

  }

  listenToKeyboard(BuildContext context) {
    if(_streamController.isClosed) {
      _streamController = StreamController<double>();

    }
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    _chuckListSink.add(bottom);

  }

  dispose() {
    _streamController.close();
  }
}

final keyboardBlock = KeyboardChangeBlock();