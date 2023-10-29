import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class MyDogs extends StatelessWidget {
  const MyDogs({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.035,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.033,
            ),
            child: Row(
              children: [
                const Text(
                  "내 반려견들",
                  style: TextStyle(
                    fontSize: 16,
                    color: blackColor,
                    fontWeight: fontWeightBold,
                  ),
                ),
                const Spacer(),
                TextButton(
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
                          "새 반려견을 등록하시겠습니까?",
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
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/dog-register");
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "+ 반려견 추가하기",
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColor,
                      fontWeight: fontWeightMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: screenWidth * 0.033,
                  ),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: lightGreyColor,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/dog_profile.jpeg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "바둑이",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: blackColor,
                                    fontWeight: fontWeightBold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "리트리버",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: mainColor,
                                    fontWeight: fontWeightMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 0,
                );
              },
              itemCount: 4,
            ),
          )
        ],
      ),
    );
  }
}
