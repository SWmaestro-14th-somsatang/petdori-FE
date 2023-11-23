import 'dart:async';
import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wooyoungsoo/utils/data.dart';

class GpsUtilProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late Timer _timer;
  final Stopwatch _stopwatch = Stopwatch();
  LatLng _currentPosition = const LatLng(36.579699, 126.977003);
  LatLng _beforePosition = const LatLng(36.579699, 126.977003);
  double _distance = 0;
  List<Position> path = <Position>[];
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  List<List<LatLng>> manPaths = <List<LatLng>>[];
  List<int> manIdx = <int>[0, 0, 0];
  List<LatLng> manPositions = <LatLng>[
    LatLng(0, 0),
    LatLng(0, 0),
    LatLng(0, 0)
  ];
  List<BitmapDescriptor> manIcon = <BitmapDescriptor>[];
  bool isDummyON = true;
  AppleMapController? mapController;
  Uint8List? mapImage;

  int colorsIndex = 0;
  List<Color> colors = <Color>[
    Color.fromARGB(255, 86, 151, 241),
    Color.fromARGB(125, 76, 175, 80),
    Color.fromARGB(125, 76, 175, 80),
    Color.fromARGB(125, 76, 175, 80),
  ];

  get currentPosition => _currentPosition;

  void setMapImage(Uint8List image) {
    mapImage = image;
  }

  void ready() {
    _stopwatch.reset();
    path.clear();
    polylines.clear();
    Future.delayed(const Duration(seconds: 2), () {
      start();
    });
  }

  void start() {
    print("GpsUtilProvider start");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _getCurrentPosition();
      print(currentPosition);
    });
    _stopwatch.start();
    isDummyON = true;
  }

  void pause() {
    print("GpsUtilProvider pause");
    _timer.cancel();
    _stopwatch.stop();
  }

  void end() {
    print("GpsUtilProvider end");
    _timer.cancel();
    isDummyON = false;
  }

  Future<Duration> getElapsedTime() async {
    return _stopwatch.elapsed;
  }

  Future<double> getSpeed() async {
    if (path.length < 2) {
      return 0;
    }
    double distance = await getDistance();
    distance = (distance / path.length) * 0.3;
    return distance;
  }

  Future<double> getDistance() async {
    if (path.length < 2) {
      return 0;
    }
    Position starPoint = path[0];
    double distance = 0;
    for (int i = 1; i < path.length; i++) {
      distance += Geolocator.distanceBetween(
        starPoint.latitude,
        starPoint.longitude,
        path[i].latitude,
        path[i].longitude,
      );
      starPoint = path[i];
    }
    return distance;
  }

  // pace 계산시 중복 계산이 될 수 있음 이 점을 고려하여 로직을 다시 생각해봐야 함.
  Future<double> getPace() async {
    if (path.length < 2) {
      return 0;
    }
    double distance = await getDistance();
    Duration elapsedTime = await getElapsedTime();
    return elapsedTime.inSeconds / distance;
  }

  Set<Polyline> getPolyline() {
    if (path.length < 2) {
      return Set<Polyline>.of(polylines.values);
    }

    LatLng startPoint = _createLatLng(path[0].latitude, path[0].longitude);
    DateTime? startPointTime = path[0].timestamp;
    LatLng endPoint = _createLatLng(path[0].latitude, path[0].longitude);
    DateTime? endPointTime = path[0].timestamp;

    for (int i = 1; i < path.length; i++) {
      final PolylineId polylineId = PolylineId('$i');

      endPoint = _createLatLng(path[i].latitude, path[i].longitude);
      endPointTime = path[i].timestamp;

      final Polyline polyline = Polyline(
        polylineId: polylineId,
        color: colors[colorsIndex],
        width: 5,
        points: <LatLng>[startPoint, endPoint],
        polylineCap: Cap.roundCap,
      );

      polylines[PolylineId('$i')] = polyline;

      startPoint = endPoint;
      startPointTime = endPointTime;
    }

    return Set<Polyline>.of(polylines.values);
  }

  void dummyHumanInit() async {
    for (var i = 1; i <= 3; i++) {
      List<point> points =
          await getCoordsPointData('assets/data/walkman_$i.csv');
      List<LatLng> latLngs = <LatLng>[];
      points.forEach((point) {
        latLngs.add(LatLng(point.lat, point.lng));
      });
      manPaths.add(latLngs);
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(
                devicePixelRatio: 0.1,
                size: Size(10, 10),
              ),
              'assets/data/walkman_img_$i.png',
              mipmaps: true)
          .then((value) => manIcon.add(value));
    }
    for (var i = 0; i < 3; i++) {
      // periodically move path
      Timer.periodic(const Duration(seconds: 3), (timer) {
        dummyHumanMove(i, manPaths[i].length);
        if (!isDummyON) {
          timer.cancel();
        }
      });
    }
  }

  void dummyHumanMove(int idx, int len) async {
    manIdx[idx] = (manIdx[idx] + 1) % len;
    manPositions[idx] = manPaths[idx][manIdx[idx]];
  }

  Set<Annotation> getAnnotation() {
    Set<Annotation> annotations = <Annotation>{};
    for (var i = 0; i < 3; i++) {
      if (manIcon.length != 3) {
        break;
      }
      annotations.add(
        Annotation(
          annotationId: AnnotationId('walkMan$i'),
          position: manPositions[i],
          icon: manIcon[i],
          onTap: () {
            print('onTap');
          },
        ),
      );
    }
    return annotations;
  }

  void dummyPathAdd() async {
    List<point> points = await getCoordsPointData('assets/data/points_0.csv');
    for (int i = 0; i < points.length; i++) {
      path.add(Position(
          latitude: points[i].lat,
          longitude: points[i].lng,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0));
    }
  }

  Future<bool> isGpsOnAndGetPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    permission = await Geolocator.requestPermission();
    print(permission);
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  Future<void> _getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      path.add(position);
      _currentPosition = _createLatLng(position.latitude, position.longitude);
      _distance = Geolocator.distanceBetween(
        _beforePosition.latitude,
        _beforePosition.longitude,
        _currentPosition.latitude,
        _currentPosition.longitude,
      );
      _beforePosition = _currentPosition;
    } catch (e) {
      _currentPosition = const LatLng(36.579699, 126.977003);
    }
  }
}
