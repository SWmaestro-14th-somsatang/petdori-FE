import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/apple_map_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/google_map_widget.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IOS 인지 아닌지 판단
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Stack(
      children: [
        isIOS ? const AppleMapWidget() : const GoogleMapWidget(),
      ],
    );
  }
}
