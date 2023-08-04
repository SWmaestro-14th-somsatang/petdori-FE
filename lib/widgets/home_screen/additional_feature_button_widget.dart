import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 홈 화면 부가 기능 버튼
///
/// [assetName] : 버튼에 보이는 이미지 경로
/// [featureName] : 버튼에 보이는 텍스트
/// [description] : 버튼에 보이는 설명
class AdditionalFeatureButton extends StatelessWidget {
  const AdditionalFeatureButton({
    super.key,
    required this.assetName,
    required this.featureName,
    required this.description,
  });

  final String assetName;
  final String featureName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // TODO: 버튼 눌렀을 때 실제 페이지로 가는 메서드를 이어야 함
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: SvgPicture.asset(assetName),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    featureName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
