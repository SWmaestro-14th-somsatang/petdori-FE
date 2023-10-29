import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class MembershipWithdrawal extends StatelessWidget {
  const MembershipWithdrawal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            "회원탈퇴",
            style: TextStyle(
              color: darkGreyColor,
              fontSize: 14,
              fontWeight: fontWeightMedium,
            ),
          ),
        ),
      ],
    );
  }
}
