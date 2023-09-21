import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<GpsUtilProvider>().dummyPathAdd();
                },
                child: Text('더미 경로 전체 추가'),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Text('더미 경로 포인트 추가'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
