import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wooyoungsoo/models/facility_model.dart';
import 'package:wooyoungsoo/services/facility_service/facility_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/nearby_facility_screen/facility_bottom_sheet_widget.dart';

/// 편의시설 조회하는 지도 위젯
///
/// [ screenWidth] : 화면의 너비
/// [ screenHeight] : 화면의 높이
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

/// 편의시설 조회하는 지도 위젯의 State 클래스
///
/// [facilityService] : 편의시설 조회 서비스
/// [nearbyFacilities] : 현재 지도에 표시되는 편의시설들
/// [mapController] : 지도 컨트롤러
/// [currentPosition] : 현재 위치
/// [hospitalIcon, beautyIcon, hotelIcon] : 동물병원, 애견미용실, 애견숙소 아이콘
/// [isLoading] : 지도 위젯이 로딩 중인지 여부
class _FacilityMapState extends State<FacilityMap> {
  final FacilityService facilityService = FacilityService();
  List<FacilityModel> nearbyFacilities = [];
  late AppleMapController mapController;
  late Position currentPosition;
  BitmapDescriptor? hospitalIcon, beautyIcon, hotelIcon;
  bool isLoading = true;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  void loadIcons() async {
    hospitalIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/hospital_icon.png",
    );
    beautyIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/beauty_icon.png",
    );
    hotelIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/hotel_icon.png",
    );
    setState(() {
      isLoading = false;
    });
  }

  void getCurrentPosition() async {
    currentPosition = await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    loadIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isLoading
              ? const SizedBox(
                  height: 90,
                  child: SpinKitCircle(
                    color: mainColor,
                    size: 50,
                  ),
                )
              : Stack(
                  children: [
                    AppleMap(
                      annotations: Set<Annotation>.of(
                        nearbyFacilities.map(
                          (facility) => Annotation(
                            annotationId: AnnotationId(facility.name),
                            position:
                                LatLng(facility.latitude, facility.longitude),
                            icon: hospitalIcon!,
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
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition.latitude,
                            currentPosition.longitude),
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
                          LatLngBounds res =
                              await mapController.getVisibleRegion();
                          LatLng northEast = res.northeast;
                          LatLng southWest = res.southwest;
                          double centerLat =
                              (northEast.latitude + southWest.latitude) / 2;
                          double centerLng =
                              (northEast.longitude + southWest.longitude) / 2;

                          int distance = Geolocator.distanceBetween(centerLat,
                                  centerLng, centerLat, southWest.longitude)
                              .toInt();
                          print(
                              "${northEast.latitude}, ${northEast.longitude}");
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
                    Positioned(
                      right: 0,
                      top: widget.screenHeight * 0.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(40, 40),
                            backgroundColor: whiteColor,
                            foregroundColor: mainColor,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder()),
                        onPressed: () {
                          getCurrentPosition();
                          mapController
                              .animateCamera(CameraUpdate.newLatLng(LatLng(
                            currentPosition.latitude,
                            currentPosition.longitude,
                          )));
                        },
                        child: const Icon(
                          Icons.gps_fixed_rounded,
                          size: 20,
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
