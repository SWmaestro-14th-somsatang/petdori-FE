import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wooyoungsoo/models/dog_detail_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class MyDogs extends StatelessWidget {
  MyDogs({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.myDogs,
  });

  final double screenHeight;
  final double screenWidth;
  final List<DogDetailModel> myDogs;
  final Map<String, String> gendorIcon = {
    "MALE": "♂",
    "FEMALE": "♀",
  };

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
                                        : NetworkImage(
                                                "${myDogs[0].dogImageUrl!}?w=50")
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
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: transparentColor,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: screenHeight * 0.425,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: screenWidth * 0.075,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 65,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: darkGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundImage: myDogs[0]
                                                            .dogImageUrl ==
                                                        null
                                                    ? const AssetImage(
                                                        "assets/images/default_dog_image.png",
                                                      )
                                                    : NetworkImage(
                                                            "${myDogs[index].dogImageUrl!}?w=100")
                                                        as ImageProvider,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                height: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          myDogs[index].dogName,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: blackColor,
                                                            fontWeight:
                                                                fontWeightBold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        myDogs[index]
                                                                    .dogGender ==
                                                                "FEMALE"
                                                            ? const Icon(
                                                                Icons.female,
                                                                color: redColor,
                                                                size: 18,
                                                              )
                                                            : const Icon(
                                                                Icons.male,
                                                                color:
                                                                    mainColor,
                                                                size: 18,
                                                              )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      myDogs[index].dogTypeName,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: darkGreyColor,
                                                        fontWeight:
                                                            fontWeightRegular,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            "🎂 생일",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: blackColor,
                                              fontWeight: fontWeightBold,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("yyyy년 MM월 dd일")
                                                .format(myDogs[index].dogBirth),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: darkGreyColor,
                                              fontWeight: fontWeightRegular,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            "⚖️ 몸무게",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: blackColor,
                                              fontWeight: fontWeightBold,
                                            ),
                                          ),
                                          Text(
                                            "${myDogs[index].dogWeight} kg",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: darkGreyColor,
                                              fontWeight: fontWeightRegular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
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
