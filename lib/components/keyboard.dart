import 'dart:async';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:keyboard_utils/keyboard_listener.dart' as keyboard_listener;

class KeyboardBloc {
  final KeyboardUtils _keyboardUtils = KeyboardUtils();
  final StreamController<double> _streamController = StreamController<double>();
  Stream<double> get stream => _streamController.stream;

  KeyboardUtils get keyboardUtils => _keyboardUtils;

  late int _idKeyboardListener;

  void start() {
    _idKeyboardListener = _keyboardUtils.add(
        listener: keyboard_listener.KeyboardListener(willHideKeyboard: () {
      _streamController.sink.add(_keyboardUtils.keyboardHeight);
    }, willShowKeyboard: (double keyboardHeight) {
      _streamController.sink.add(keyboardHeight);
    }));
  }

  void dispose() {
    _keyboardUtils.unsubscribeListener(subscribingId: _idKeyboardListener);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
    _streamController.close();
  }
}
