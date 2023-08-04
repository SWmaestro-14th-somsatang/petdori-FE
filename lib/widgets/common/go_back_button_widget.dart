import 'package:flutter/material.dart';

/// 뒤로가기 버튼 위젯
class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
  });

  /// 뒤로가기 기능을 수행하는 메서드
  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      color: Colors.black,
      onPressed: () => goBack(context),
    );
  }
}
