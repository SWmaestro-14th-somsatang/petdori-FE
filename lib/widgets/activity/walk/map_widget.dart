import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/walk_state_provider.dart';
import 'package:wooyoungsoo/widgets/activity/walk/apple_map_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/google_map_widget.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function toggleMapExpand =
        context.read<WalkStateProvider>().toggleMapExpanded;
    bool isExpanded = context.watch<WalkStateProvider>().isExpanded;
    // IOS 인지 아닌지 판단
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return InkWell(
      onTap: () => {
        context.read<WalkStateProvider>().toggleMapExpanded(),
        context.read<GpsUtilProvider>().getCurrentPosition(),
      },
      child: Stack(
        children: [
          AbsorbPointer(
            absorbing: !isExpanded,
            child: isIOS ? const AppleMapWidget() : const GoogleMapWidget(),
          ),
          if (isExpanded)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => toggleMapExpand(),
                color: Colors.black,
              ),
            ),
          if (isExpanded)
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_drop_up),
                onPressed: () => toggleMapExpand(),
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
