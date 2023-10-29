import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/dog_info_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class MyDogs extends StatelessWidget {
  const MyDogs({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.myDogs,
  });

  final double screenHeight;
  final double screenWidth;
  final List<DogInfoModel> myDogs;

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
          myDogs.isEmpty
              ? const SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          "assets/images/default_dog_image.png",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "아직 등록된 반려견이 없어요!",
                        style: TextStyle(
                          fontSize: 16,
                          color: mediumGreyColor,
                          fontWeight: fontWeightMedium,
                        ),
                      ),
                    ],
                  ),
                )
              : myDogs.length == 1
                  ? SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 80,
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: myDogs[0].dogImageUrl ==
                                            null
                                        ? const AssetImage(
                                            "assets/images/default_dog_image.png",
                                          )
                                        : NetworkImage(myDogs[0].dogImageUrl!)
                                            as ImageProvider,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          myDogs[0].dogName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: blackColor,
                                            fontWeight: fontWeightBold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          myDogs[0].dogTypeName,
                                          style: const TextStyle(
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
                        ],
                      ),
                    )
                  : SizedBox(
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: myDogs[index]
                                                  .dogImageUrl ==
                                              null
                                          ? const AssetImage(
                                              "assets/images/default_dog_image.png",
                                            )
                                          : NetworkImage(
                                                  myDogs[index].dogImageUrl!)
                                              as ImageProvider,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            myDogs[index].dogName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: blackColor,
                                              fontWeight: fontWeightBold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            myDogs[index].dogTypeName,
                                            style: const TextStyle(
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
                        itemCount: myDogs.length,
                      ),
                    )
        ],
      ),
    );
  }
}
