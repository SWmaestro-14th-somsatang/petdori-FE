import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/nearby_facility_screen/facility_map_widget.dart';

/// 주변 편의시설 화면
class NearbyFacilityScreen extends StatefulWidget {
  const NearbyFacilityScreen({Key? key}) : super(key: key);

  @override
  State<NearbyFacilityScreen> createState() => _NearbyFacilityScreenState();
}

class _NearbyFacilityScreenState extends State<NearbyFacilityScreen> {
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
