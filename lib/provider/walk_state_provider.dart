import 'package:flutter/foundation.dart';

class WalkStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isReady = false;
  bool _isStartted = false;
  bool _isPaused = false;
  bool _isFinished = true;

  bool get isReady => _isReady;
  bool get isStartted => _isStartted;
  bool get isPaused => _isPaused;
  bool get isFinished => _isFinished;

  void ready() {
    _isStartted = true;
    _isReady = true;
    _isPaused = true;
    _isFinished = false;
    notifyListeners();
  }

  void start() {
    _isStartted = true;
    _isReady = false;
    _isPaused = false;
    _isFinished = false;
    notifyListeners();
  }

  void pause() {
    _isPaused = !_isPaused;
    print(_isPaused);
    notifyListeners();
  }

  void end() {
    _isReady = false;
    _isStartted = false;
    _isPaused = false;
    _isFinished = true;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isReady',
        value: isReady, ifTrue: 'isReady', ifFalse: 'isNotReady'));
    properties.add(FlagProperty('isStartted',
        value: isStartted, ifTrue: 'isStartted', ifFalse: 'isNotStartted'));
    properties.add(FlagProperty('isPaused',
        value: isPaused, ifTrue: 'isPaused', ifFalse: 'isNotPaused'));
    properties.add(FlagProperty('isFinished',
        value: isFinished, ifTrue: 'isFinished', ifFalse: 'isNotFinished'));
  }
}
