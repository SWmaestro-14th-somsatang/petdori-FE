import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wooyoungsoo/models/dog_detail_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class DogDetailModal extends StatelessWidget {
  const DogDetailModal({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.dog,
  });

  final double screenHeight;
  final double screenWidth;
  final DogDetailModel dog;

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 65,
                height: 5,
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(30),
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
                backgroundImage: dog.dogImageUrl == null
                    ? const AssetImage(
                        "assets/images/default_dog_image.png",
                      )
                    : NetworkImage("${dog.dogImageUrl!}?w=100")
                        as ImageProvider,
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          dog.dogName,
                          style: const TextStyle(
                            fontSize: 20,
                            color: blackColor,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        dog.dogGender == "FEMALE"
                            ? const Icon(
                                Icons.female,
                                color: redColor,
                                size: 18,
                              )
                            : const Icon(
                                Icons.male,
                                color: mainColor,
                                size: 18,
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      dog.dogTypeName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: darkGreyColor,
                        fontWeight: fontWeightRegular,
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
            DateFormat("yyyy년 MM월 dd일").format(dog.dogBirth),
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
            "${dog.dogWeight} kg",
            style: const TextStyle(
              fontSize: 16,
              color: darkGreyColor,
              fontWeight: fontWeightRegular,
            ),
          ),
        ],
      ),
    );
  }
}
