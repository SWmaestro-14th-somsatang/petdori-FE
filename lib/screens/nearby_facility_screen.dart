import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wooyoungsoo/models/facility_model.dart';
import 'package:wooyoungsoo/services/facility_service/facility_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';

/// 주변 편의시설 화면
class NearbyFacilityScreen extends StatefulWidget {
  const NearbyFacilityScreen({Key? key}) : super(key: key);

  @override
  State<NearbyFacilityScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<NearbyFacilityScreen> {
  // final FacilityService facilityService = FacilityService();
  // List<FacilityModel> nearbyFacilities = [];
  // late AppleMapController mapController;
  // BitmapDescriptor? defaultIcon;

  // void _onMapCreated(AppleMapController controller) {
  //   mapController = controller;
  // }

  // void loadDefaultIcon() async {
  //   defaultIcon = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(
  //       size: Size(12, 12),
  //     ),
  //     "assets/images/hotel_icon.png",
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   loadDefaultIcon();
  // }

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
      body: FacilityMap(screenWidth: screenWidth, screenHeight: screenHeight),
    );
  }
}

class FacilityMap extends StatefulWidget {
  const FacilityMap({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);
  final double screenWidth;
  final double screenHeight;

  @override
  State<FacilityMap> createState() => _FacilityMapState();
}

class _FacilityMapState extends State<FacilityMap> {
  final FacilityService facilityService = FacilityService();
  List<FacilityModel> nearbyFacilities = [];
  late AppleMapController mapController;
  BitmapDescriptor? defaultIcon;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  void loadDefaultIcon() async {
    defaultIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/hotel_icon.png",
    );
  }

  @override
  void initState() {
    super.initState();
    loadDefaultIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              AppleMap(
                annotations: Set<Annotation>.of(
                  nearbyFacilities.map(
                    (facility) => Annotation(
                      annotationId: AnnotationId(facility.name),
                      position: LatLng(facility.latitude, facility.longitude),
                      icon: defaultIcon!,
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          backgroundColor: transparentColor,
                          builder: (BuildContext context) {
                            return FacilityBottomSheet(
                              facility: facility,
                              width: widget.screenWidth,
                              height: widget.screenHeight * 0.18,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                onMapCreated: _onMapCreated,
                trackingMode: TrackingMode.follow,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.328628, 127.100229),
                ),
              ),
              Positioned(
                left: widget.screenWidth * 0.5 - 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 36),
                    backgroundColor: whiteColor,
                    foregroundColor: mainColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: mediumGreyColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () async {
                    await mapController.getZoomLevel();
                    LatLngBounds res = await mapController.getVisibleRegion();
                    LatLng northEast = res.northeast;
                    LatLng southWest = res.southwest;
                    double centerLat =
                        (northEast.latitude + southWest.latitude) / 2;
                    double centerLng =
                        (northEast.longitude + southWest.longitude) / 2;

                    int distance = Geolocator.distanceBetween(centerLat,
                            centerLng, centerLat, southWest.longitude)
                        .toInt();
                    print("${northEast.latitude}, ${northEast.longitude}");
                    print("centerLat: $centerLat, centerLng: $centerLng");
                    print("distance: $distance");

                    nearbyFacilities =
                        await facilityService.getNearbyFacilities(
                      latitude: centerLat,
                      longitude: centerLng,
                      radius: distance,
                    );

                    setState(() {});
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 18,
                        color: mainColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 14,
                        child: Text(
                          "현 지도에서 검색",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: fontWeightMedium,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FacilityBottomSheet extends StatelessWidget {
  const FacilityBottomSheet({
    Key? key,
    required this.facility,
    required this.width,
    required this.height,
  }) : super(key: key);

  final FacilityModel facility;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              facility.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: fontWeightBold,
                color: blackColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            facility.operatingHourInfo.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    facility.operatingHourInfo,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeightRegular,
                      color: blackColor,
                    ),
                  ),
            facility.operatingHourInfo.isEmpty
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 10,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  facility.distanceInfo,
                  style: const TextStyle(
                    color: blackColor,
                    fontSize: 14,
                    fontWeight: fontWeightBold,
                  ),
                ),
                Text(
                  facility.address,
                  style: const TextStyle(
                    color: darkGreyColor,
                    fontSize: 14,
                    fontWeight: fontWeightRegular,
                  ),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy_rounded,
                    color: mainColor,
                    size: 18,
                  ),
                  label: const Text(
                    "복사",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 14,
                      fontWeight: fontWeightMedium,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
