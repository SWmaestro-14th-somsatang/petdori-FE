import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';

/// 주변 편의시설 화면
class NearbyFacilityScreen extends StatefulWidget {
  const NearbyFacilityScreen({Key? key}) : super(key: key);

  @override
  State<NearbyFacilityScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<NearbyFacilityScreen> {
  late AppleMapController mapController;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const int currentIndex = 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        shadowColor: transparentColor,
        leadingWidth: 115,
        leading: Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: screenWidth * 0.033,
          ),
          child: const Text(
            "내 주변",
            style: TextStyle(
              fontSize: 18,
              fontWeight: fontWeightBold,
              color: blackColor,
            ),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      bottomNavigationBar:
          const PetdoriNavigationBar(currentIndex: currentIndex),
      body: Column(
        children: [
          Expanded(
            child: AppleMap(
              onMapCreated: _onMapCreated,
              minMaxZoomPreference: const MinMaxZoomPreference(17, 17),
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.328628, 127.100229),
                zoom: 17.0,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              LatLngBounds res = await mapController.getVisibleRegion();
              LatLng northEast = res.northeast;
              LatLng southWest = res.southwest;
              double centerLat = (northEast.latitude + southWest.latitude) / 2;
              double centerLng =
                  (northEast.longitude + southWest.longitude) / 2;

              int distance = Geolocator.distanceBetween(
                      northEast.latitude,
                      northEast.longitude,
                      southWest.latitude,
                      southWest.longitude) ~/
                  2;
              print("centerLat: $centerLat, centerLng: $centerLng");
              print("distance: $distance");
            },
            child: const Text("버튼"),
          ),
        ],
      ),
    );
  }
}
