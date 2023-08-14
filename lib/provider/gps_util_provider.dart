import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wooyoungsoo/utils/data.dart';

class GpsUtilProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late Function _stateCallback;
  List<Position> path = <Position>[];
  // drawline on map
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  Uint8List? _imageBytes;

  int colorsIndex = 0;
  List<Color> colors = <Color>[
    // Color.fromARGB(127, 156, 39, 176),
    // Color.fromARGB(127, 156, 39, 176),
    // Colors.purple,
    // Colors.red,
    Color.fromARGB(125, 76, 175, 80),
    Color.fromARGB(125, 76, 175, 80),
    Color.fromARGB(125, 76, 175, 80),
    Color.fromARGB(125, 76, 175, 80),
    // Colors.pink,
  ];

  late List<LatLng> points;

  get stateCallback => _stateCallback;

  Set<Polyline> getPolyline() {
    if (path.length < 2) {
      return Set<Polyline>.of(polylines.values);
    }
    print("GetPolyline");

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
        color: colors[colorsIndex++ % colors.length],
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

  void dummyPointAdd() {}

  void dummyPathAdd() {
    List<point> points = getCoordsPointData(
        '/Users/binary_ho/Project/FlutterProject/somsatang_app/lib/data/points_0.csv');
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

  void setStateCallback(Function stateCallback) {
    _stateCallback = stateCallback;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  Future<void> getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      path.add(position);
    } catch (e) {
      print(e);
      // TODO 초기에 gps 오류를 제거해야 함
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
