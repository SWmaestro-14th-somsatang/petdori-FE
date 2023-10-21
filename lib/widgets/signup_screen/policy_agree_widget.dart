import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class PolicyAgreeWidget extends StatelessWidget {
  const PolicyAgreeWidget({
    super.key,
    required this.screenWidth,
    required this.policyName,
    required this.isAgree,
    required this.handleAgree,
    required this.showPolicy,
  });

  final String policyName;
  final bool isAgree;
  final double screenWidth;
  final VoidCallback handleAgree, showPolicy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.03,
              right: screenWidth * 0.015,
            ),
            child: SizedBox(
              width: 20,
              height: 20,
              child: ElevatedButton(
                onPressed: handleAgree,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAgree ? mainColor : lightGreyColor,
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  shadowColor: Colors.transparent,
                ),
                child: const Icon(
                  Icons.check,
                  color: whiteColor,
                  size: 14,
                ),
              ),
            ),
          ),
          Baseline(
            baselineType: TextBaseline.alphabetic,
            baseline: 14,
            child: Text(
              policyName,
              style: TextStyle(
                fontSize: 14,
                color: isAgree ? blackColor : mediumGreyColor,
                fontWeight: fontWeightMedium,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: showPolicy,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: isAgree ? blackColor : darkGreyColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
