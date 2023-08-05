import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 회원가입 버튼 위젯
///
/// [_isReady] 값이 true일 때만 버튼이 활성화됨
/// [_onPressed] 버튼 클릭 시 실행될 콜백 함수
class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required bool isReady,
    required VoidCallback onPressed,
  })  : _isReady = isReady,
        _onPressed = onPressed;

  final bool _isReady;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    // 화면 너비
    final double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: _isReady ? _onPressed : null,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(screenWidth * 0.9, 55),
        backgroundColor: _isReady ? mainPurpleColor : Colors.grey.shade300,
        foregroundColor: _isReady ? whiteColor : Colors.grey,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: const Text('회원가입 완료'),
    );
  }
}
