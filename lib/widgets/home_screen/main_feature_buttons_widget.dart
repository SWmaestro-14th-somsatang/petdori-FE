import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/home_screen/main_feature_button_widget.dart';

/// 홈 화면 주요 기능 버튼 목록
class MainFeatureButtons extends StatelessWidget {
  const MainFeatureButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              "메인 서비스",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 170,
            child: GridView.count(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: const [
                MainFeatureButton(
                  buttonText: "결제",
                  buttonColor: Color(0xFFe9eef1),
                  assetName: "assets/images/cart.svg",
                ),
                MainFeatureButton(
                  buttonText: "사료",
                  buttonColor: Color(0xFFf7efe4),
                  assetName: "assets/images/bone.svg",
                ),
                MainFeatureButton(
                  buttonText: "차트 목록",
                  buttonColor: Color(0xFFe8eaf7),
                  assetName: "assets/images/health_chart.svg",
                ),
                MainFeatureButton(
                  buttonText: "혈당",
                  buttonColor: Color(0xFFf5ecef),
                  assetName: "assets/images/heart_pulse.svg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
