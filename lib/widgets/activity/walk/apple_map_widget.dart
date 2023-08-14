import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';

class AppleMapWidget extends StatefulWidget {
  const AppleMapWidget({Key? key}) : super(key: key);

  @override
  _AppleMapWidgetState createState() => _AppleMapWidgetState();
}

class _AppleMapWidgetState extends State<AppleMapWidget> {
  late AppleMapController mapController;

  void _onMapCreated(AppleMapController controller) {
    print("onMapCreated");
    mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {
    //     print("Set State");
    //   });
    // });

    // Future.delayed(const Duration(seconds: 3), () {
    //   print("Cancel Timer");
    //   timer.cancel();
    // });
  }

  @override
  Widget build(BuildContext context) {
    context.read<GpsUtilProvider>().setStateCallback(() {
      setState(() {});
    });
    return AppleMap(
      onMapCreated: _onMapCreated,
      trackingMode: TrackingMode.follow,
      myLocationEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.579699, 126.977003),
        zoom: 15.0,
      ),
      polylines: context.read<GpsUtilProvider>().getPolyline(),
    );
  }
}
