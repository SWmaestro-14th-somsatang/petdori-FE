import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wooyoungsoo/models/profile_model.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/navigation_bar_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/go_to_another_page_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/membership_withdrawal_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/my_dogs_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/notification_setting_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/profile_widget.dart';
import 'package:wooyoungsoo/widgets/my_page_screen/version_info_widget.dart';

/// 마이페이지 화면
///
/// [screenWidth], [screenHeight] 화면의 너비와 높이
/// [currentIndex] 현재 화면의 인덱스
class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  final AuthService authService = AuthService();
  late ProfileModel? profile;
  bool isLoading = true;

  Future loadProfile() async {
    profile = await authService.getProfile();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const int currentIndex = 3;

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
            "마이페이지",
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
      body: isLoading == true
          ? const SpinKitCircle(
              color: mainColor,
              size: 50,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Profile(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    profile: profile,
                  ),
                  MyDogs(screenHeight: screenHeight, screenWidth: screenWidth),
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.03,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.033,
                    ),
                    child: Column(
                      children: [
                        GoToAnotherPage(
                          text: "이용약관",
                          onPressed: () {},
                        ),
                        const Gap(),
                        GoToAnotherPage(
                          text: "개인정보처리방침",
                          onPressed: () {},
                        ),
                        const Gap(),
                        const VersionInfo(),
                        const Gap(),
                        const NotificationSetting(),
                        const Gap(),
                        const Divider(
                          color: lightGreyColor,
                          thickness: 1,
                        ),
                        const Gap(),
                        GoToAnotherPage(
                          text: "친구 관리",
                          onPressed: () {},
                        ),
                        const Gap(),
                        const MembershipWithdrawal(),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}
