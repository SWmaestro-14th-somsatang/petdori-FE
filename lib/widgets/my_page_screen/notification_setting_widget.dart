import 'package:flutter/cupertino.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: 14,
          child: Text(
            "알림 설정",
            style: TextStyle(
              fontSize: 16,
              color: blackColor,
              fontWeight: fontWeightMedium,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 40,
          height: 30,
          child: FittedBox(
            fit: BoxFit.contain,
            child: CupertinoSwitch(
              value: true,
              onChanged: (value) {},
              activeColor: mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
