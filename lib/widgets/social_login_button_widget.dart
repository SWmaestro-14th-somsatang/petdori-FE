import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooyoungsoo/screens/home_screen.dart';

/// 소셜 로그인 버튼 위젯
///
/// [assetName] 소셜 로고 이미지 경로
/// [buttonText] 버튼에 표시할 텍스트
/// [buttonColor] 버튼 배경색 (각 소셜미디어에서 권장하는 가이드라인을 참고함)
/// [textColor] 버튼 텍스트 색상 (각 소셜미디어에서 권장하는 가이드라인을 참고함)
class SosialLoginButton extends StatelessWidget {
  const SosialLoginButton({
    super.key,
    required this.assetName,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
  });

  final String assetName, buttonText;
  final Color buttonColor, textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // TODO(Cho-SangHyun): 추후 실제 로그인 기능을 연결해야 함
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 45),
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 75,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SvgPicture.asset(
            assetName,
            width: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            buttonText,
          ),
        ],
      ),
    );
  }
}
