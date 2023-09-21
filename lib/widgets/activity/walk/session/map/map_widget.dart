import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/apple_map_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/google_map_widget.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function toggleMapExpand =
        context.read<SessionStateProvider>().toggleMapExpanded;
    bool isExpanded = context.watch<SessionStateProvider>().isExpanded;
    // IOS 인지 아닌지 판단
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return InkWell(
      onTap: () => {
        context.read<SessionStateProvider>().toggleMapExpanded(),
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
