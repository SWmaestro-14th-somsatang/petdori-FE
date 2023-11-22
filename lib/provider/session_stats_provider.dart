import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';

class SessionStatsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final GpsUtilProvider gpsUtilProvider;
  SessionStatsProvider({required this.gpsUtilProvider});
  late Timer timer;
  String _distance = "0.00km";
  String _speed = "00.0km/h";
  String _calorie = "0";
  String _elapsedTime = "00:00";
  String _pace = "-'--''";
  String _step = "0";
  String _altitude = "0";
  String _heartRate = "0";
  double progress = 0.1;
  double goal = 10;

  Future<String> getElapsedTime() async {
    gpsUtilProvider.getElapsedTime().then((value) {
      progress = value.inSeconds / goal;
      String hours =
          (value.inSeconds / 3600).floor().toString().padLeft(2, '0');
      String minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
      String seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
      if (hours == "00") {
        return _elapsedTime = "$minutes:$seconds";
      } else {
        return _elapsedTime = "$hours:$minutes";
      }
    }).onError((error, stackTrace) {
      return _elapsedTime;
    });
    return _elapsedTime;
  }

  Future<String> getDistance() async {
    gpsUtilProvider.getDistance().then((value) {
      int m = value.toInt();
      int km = m ~/ 1000;
      if (km > 9) {
        _distance = "$km.${m.toString().substring(0, 1)} km";
      } else if (10 > km) {
        _distance = "$km.${m.toString().substring(0, 2)} km";
      }
      return _distance;
    }).onError((error, stackTrace) {
      return _distance;
    });
    return _distance;
  }

  Future<String> getSpeed() async {
    gpsUtilProvider.getSpeed().then((value) {
      _speed = "${value.toStringAsFixed(1)}km/h";
      return _speed;
    }).onError((error, stackTrace) {
      return _speed;
    });
    return _speed;
  }

  Future<String> getCalorie() async {
    return _calorie;
  }

  Future<String> getPace() async {
    gpsUtilProvider.getDistance().then((value) {
      print("");
    }).onError((error, stackTrace) {
      print("object");
    });

    return _pace;
  }

  Future<String> getStep() async {
    return _step;
  }

  Future<String> getAltitude() async {
    return _altitude;
  }

  Future<String> getHeartRate() async {
    return _heartRate;
  }

  void ready() {
    Future.delayed(const Duration(seconds: 3), () {
      start();
    });
  }

  void start() {
    print("SessionStatsProvider start");
  }

  void pause() {
    print("SessionStatsProvider pause");
  }

  void end() {
    _distance = "0.00km";
    _speed = "00.0km/h";
  }
}
