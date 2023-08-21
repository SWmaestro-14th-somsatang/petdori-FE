import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/provider/session_stats_provider.dart';

class ActivityControllerButtons extends StatelessWidget {
  const ActivityControllerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: FloatingActionButton(
                heroTag: "activity_setting_btn",
                backgroundColor: Colors.white,
                onPressed: () => {},
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                heroTag: "activity_start_btn",
                backgroundColor: const Color.fromARGB(255, 136, 140, 247),
                onPressed: () => {
                  context
                      .read<GpsUtilProvider>()
                      .isGpsOnAndGetPermission()
                      .then((state) => {
                            if (state)
                              {
                                context.read<SessionStateProvider>().ready(),
                                context.read<SessionStatsProvider>().ready(),
                                context.read<GpsUtilProvider>().ready(),
                              }
                            else
                              {
                                print("GPS가 꺼져있거나 권한이 없습니다."),
                              }
                          }),
                },
                child: const Text(
                  "시작",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: FloatingActionButton(
                heroTag: "activity_pet_btn",
                backgroundColor: Colors.white,
                onPressed: () => {},
                child: const Icon(
                  Icons.catching_pokemon,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 100,
          height: 35,
          child: ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              elevation: 0.5,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            child: const Text(
              "산책 설정",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
