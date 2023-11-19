import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_stats_grid_widget.dart';

class ActivityResultScreen extends StatelessWidget {
  static const routeName = '/activity-result';

  @override
  Widget build(BuildContext context) {
    // final ActivityResultScreenArguments args =
    //     ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "산책 결과",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateTime.now().toString().substring(0, 16),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "🎉고생하셨어요!\n산책 결과는 다음과 같아요",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const SizedBox(
                width: 400,
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/wooyoungsoo.png'),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const WalkStatsGridWidget(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "함께 산책한 강아지들",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // 강아지 리스트 위젯
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "오늘의 산책을\n사진으로 남겨볼까요?📷",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              // 사진 업로드 버튼 위젯
              const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
