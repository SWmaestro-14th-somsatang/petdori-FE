import 'package:flutter/foundation.dart';

class SessionStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isReady = false;
  bool _isStarted = false;
  bool _isPaused = false;
  bool _isFinished = true;
  bool _isExpanded = false;

  bool get isReady => _isReady;
  bool get isStarted => _isStarted;
  bool get isPaused => _isPaused;
  bool get isFinished => _isFinished;
  bool get isExpanded => _isExpanded;

  void ready() {
    _isStarted = false;
    _isReady = true;
    _isPaused = false;
    _isFinished = false;
    notifyListeners();
  }

  void start() {
    _isStarted = true;
    _isReady = false;
    _isPaused = false;
    _isFinished = false;
    notifyListeners();
  }

  void pause() {
    _isPaused = true;
    notifyListeners();
  }

  void end() {
    _isReady = false;
    _isStarted = false;
    _isPaused = false;
    _isFinished = true;
    notifyListeners();
  }

  void toggleMapExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isReady',
        value: isReady, ifTrue: 'isReady', ifFalse: 'isNotReady'));
    properties.add(FlagProperty('isStarted',
        value: isStarted, ifTrue: 'isStarted', ifFalse: 'isNotStartted'));
    properties.add(FlagProperty('isPaused',
        value: isPaused, ifTrue: 'isPaused', ifFalse: 'isNotPaused'));
    properties.add(FlagProperty('isFinished',
        value: isFinished, ifTrue: 'isFinished', ifFalse: 'isNotFinished'));
  }
}
