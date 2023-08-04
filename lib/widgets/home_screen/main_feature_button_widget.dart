import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 홈 화면 주요 기능 버튼
///
/// [buttonText] : 버튼에 보이는 텍스트
/// [buttonColor] : 버튼 배경색
/// [assetName] : 버튼에 보이는 이미지 경로
class MainFeatureButton extends StatelessWidget {
  const MainFeatureButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.assetName,
  });

  final String buttonText;
  final Color buttonColor;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // TODO: 버튼 눌렀을 때 실제 페이지로 가는 메서드를 이어야 함
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            child: SvgPicture.asset(assetName),
          ),
          const SizedBox(width: 10),
          Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
