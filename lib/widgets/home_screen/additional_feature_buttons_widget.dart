import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/home_screen/additional_feature_button_widget.dart';

/// 홈 화면 부가 기능 버튼 목록
///
/// [featureImagePaths] : 목록에서 보여줄 버튼에 보이는 이미지 경로들
/// [featureNames] : 목록에서 보여줄 버튼에 보이는 텍스트들
/// [descriptions] : 목록에서 보여줄 버튼에 보이는 설명들
class AdditionalFeatureButtons extends StatelessWidget {
  AdditionalFeatureButtons({
    super.key,
  });

  final List<String> featureImagePaths = [
    "assets/images/dog_walk.svg",
    "assets/images/pet_doctors.svg",
  ];

  final List<String> featureNames = [
    "산책 및 경로 추천",
    "화상 상담",
  ];

  final List<String> descriptions = [
    "같은 동네 사람들이 다녀간 길을 따라 걸어볼까요?",
    "지금 당장 1 : 1 실시간 진료를 받아보세요!",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              "부가 서비스",
              style: TextStyle(
                fontSize: 16,
                fontWeight: fontWeightBold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: featureNames.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                height: 130,
                child: AdditionalFeatureButton(
                  assetName: featureImagePaths[index],
                  featureName: featureNames[index],
                  description: descriptions[index],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
          ),
        ],
      ),
    );
  }
}
