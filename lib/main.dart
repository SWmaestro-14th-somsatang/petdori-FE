import 'package:flutter/material.dart';
import 'package:wooyoungsoo/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // TODO(Cho-SangHyun): 추후 기로그인 여부에 따라 바로 홈으로 가도록 해야 함
      home: LoginScreen(),
    );
  }
}
