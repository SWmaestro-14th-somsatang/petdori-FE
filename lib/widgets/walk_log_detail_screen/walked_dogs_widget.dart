import 'package:flutter/material.dart';
import 'package:wooyoungsoo/models/walk_log_detail_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 산책 기록 상세 화면의 산책한 강아지들 위젯
///
/// [screenWidth] 화면의 너비
/// [walkedDogs] 산책한 강아지들
class WalkedDogs extends StatelessWidget {
  const WalkedDogs({
    super.key,
    required this.screenWidth,
    required this.walkedDogs,
  });

  final double screenWidth;
  final List<WalkedDogModel> walkedDogs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.033,
          ),
          child: const Row(
            children: [
              Text(
                "함께 산책한 강아지들",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 18,
                  fontWeight: fontWeightBold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: screenWidth * 0.934,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: walkedDogs[index].dogImageUrl == null
                        ? const AssetImage(
                            "./assets/images/default_dog_image.png",
                          )
                        : NetworkImage(
                            walkedDogs[index].dogImageUrl!,
                          ) as ImageProvider,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        walkedDogs[index].dogName,
                        style: const TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: fontWeightBold,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "약 ${walkedDogs[index].burnedCalorie}kcal 소모",
                        style: const TextStyle(
                          color: darkGreyColor,
                          fontSize: 14,
                          fontWeight: fontWeightRegular,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: walkedDogs.length,
          ),
        ),
      ],
    );
  }
}
