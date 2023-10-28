import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/services/region_info_service/region_info_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:geolocator/geolocator.dart';

/// 메인 화면 현재 날씨
///
/// [screenWidth] : 화면 너비
class CurrentWeather extends StatefulWidget {
  const CurrentWeather({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

/// 메인 화면 현재 날씨의 state
///
/// [currentPosition] 현재 위치
/// [sigu] 현재 위치의 시-구 정보
/// [isLoading] 현재 위치를 불러오는 중인지 여부
class _CurrentWeatherState extends State<CurrentWeather> {
  final RegionInfoService regionInfoService = RegionInfoService();
  late Position currentPosition;
  late String sigu;
  bool isLoading = true;

  Future _determineSigu() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition();
    sigu = await regionInfoService.getRegionInfo(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _determineSigu();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.934,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: lightGreyColor,
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 25),
              isLoading
                  ? const SizedBox(
                      height: 90,
                      child: SpinKitCircle(
                        color: mainColor,
                        size: 50,
                      ),
                    )
                  : Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "지금 ",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 18,
                                  fontWeight: fontWeightRegular,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                              TextSpan(
                                text: sigu,
                                style: const TextStyle(
                                  color: mainColor,
                                  fontSize: 18,
                                  fontWeight: fontWeightBold,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                              const TextSpan(
                                text: "는...",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 18,
                                  fontWeight: fontWeightRegular,
                                  fontFamily: "NotoSansKR",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Text(
                              "⛅️",
                              style: TextStyle(
                                fontSize: 34,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "조금은 흐린 날씨",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 18,
                                fontWeight: fontWeightMedium,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(widget.screenWidth * 0.868, 50),
                  backgroundColor: mainColor,
                  foregroundColor: whiteColor,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
                child: const Text(
                  "산책 시작하기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: fontWeightBold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
