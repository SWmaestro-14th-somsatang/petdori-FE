import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/feature_navigation_button_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Map<String, String> imagePathAndFeatureName = {
    "assets/images/blood_sugar_board.svg": "연속혈당 측정 및 분석",
    "assets/images/dog_walk.svg": "산책 및 경로 추천",
    "assets/images/pet_doctors.svg": "화상 상담",
    "assets/images/memory_with_dog.svg": "추억 저장 및 공유"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 70,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var entry in imagePathAndFeatureName.entries)
              FeatureNavigationButton(
                featureName: entry.value,
                assetName: entry.key,
                // 나중에 실제 해당 기능에 대한 페이지로 넘어가는 메서드를 넘기는 식으로 수정할 예정
                onTap: () {},
              ),
          ],
        ),
      ),
    );
  }
}
