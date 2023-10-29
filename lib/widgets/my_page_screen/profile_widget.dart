import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/profile_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/provider_icon_widget.dart';

class Profile extends StatelessWidget {
  Profile({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.profile,
    required this.logout,
  });

  final double screenHeight;
  final double screenWidth;
  ProfileModel? profile;
  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    print(profile!.profileImageUrl);
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.015),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: profile!.profileImageUrl == null
                ? const AssetImage(
                    "./assets/images/default_profile.png",
                  )
                : NetworkImage(profile!.profileImageUrl!) as ImageProvider,
          ),
          SizedBox(
            width: screenWidth * 0.033,
          ),
          SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${profile!.name} 님",
                  style: const TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: fontWeightBold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    ProviderIcon(provider: profile!.provider.toLowerCase()),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      profile!.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: mediumGreyColor,
                        fontWeight: fontWeightRegular,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text(
                      "로그아웃하시겠습니까?",
                      style: TextStyle(
                        fontFamily: "NotoSansKR",
                      ),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("닫기"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text("확인"),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "로그아웃",
                style: TextStyle(
                  fontSize: 14,
                  color: mediumGreyColor,
                  fontWeight: fontWeightRegular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
