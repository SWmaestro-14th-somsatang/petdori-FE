import 'dart:async';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class AppleMapWidget extends StatefulWidget {
  const AppleMapWidget({Key? key}) : super(key: key);

  @override
  _AppleMapWidgetState createState() => _AppleMapWidgetState();
}

class _AppleMapWidgetState extends State<AppleMapWidget> {
  late AppleMapController mapController;
  late Timer timer;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: mapWidgetRebuildCycle),
        (timer) {
      if (!context.read<SessionStateProvider>().isPaused) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppleMap(
      onMapCreated: _onMapCreated,
      trackingMode: TrackingMode.follow,
      myLocationEnabled: true,
      annotations: Set<Annotation>.of(
        context.read<GpsUtilProvider>().getAnnotation(),
      ),
      initialCameraPosition: CameraPosition(
        target: context.read<GpsUtilProvider>().currentPosition,
        zoom: 15.0,
      ),
      polylines: context.read<GpsUtilProvider>().getPolyline(),
      snapshotOptions: const SnapshotOptions(
        showAnnotations: false,
      ),
    );
  }
}
