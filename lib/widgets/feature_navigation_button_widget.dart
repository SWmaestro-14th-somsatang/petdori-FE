import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// HomeScreen에서 사용되는 기능 버튼 위젯
///
/// [featureName] 기능 이름
/// [assetName] 기능 관련 이미지 경로
/// [onTap] 해당 위젯(기능 버튼)을 눌렀을 때 실행되는 메서드
class FeatureNavigationButton extends StatelessWidget {
  const FeatureNavigationButton({
    super.key,
    required this.featureName,
    required this.assetName,
    required this.onTap,
  });

  final String featureName, assetName;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.875,
          height: MediaQuery.of(context).size.height * 0.275,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 20,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      featureName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: SvgPicture.asset(assetName),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
