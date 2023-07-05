import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooyoungsoo/screens/home_screen.dart';

class SosialLoginButton extends StatelessWidget {
  const SosialLoginButton({
    super.key,
    required this.assetName,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
  });

  final String assetName, buttonText;
  final int buttonColor, textColor;

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
          backgroundColor: Color(buttonColor),
          foregroundColor: Color(textColor),
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
