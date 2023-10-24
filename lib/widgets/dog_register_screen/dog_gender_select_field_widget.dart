import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 강아지 성별 선택 시 사용되는 위젯
///
/// [screenWidth] 화면 너비
/// [dogGender] 선택한 강아지 성별
/// [isNeutered] 선택한 강아지 중성화 여부
/// [setGenderToMale] 강아지 성별을 수컷으로 설정하는 콜백 함수
/// [setGenderToFemale] 강아지 성별을 암컷으로 설정하는 콜백 함수
/// [setIsNeutered] 강아지 중성화 여부를 설정하는 콜백 함수
class DogGenderSelectField extends StatelessWidget {
  const DogGenderSelectField({
    super.key,
    required this.screenWidth,
    required this.dogGender,
    required this.isNeutered,
    required this.setGenderToMale,
    required this.setGenderToFemale,
    required this.setIsNeutered,
  });

  final double screenWidth;
  final String? dogGender;
  final bool? isNeutered;

  final VoidCallback setGenderToMale, setGenderToFemale, setIsNeutered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: thinGreyColor), // 위쪽 실선
          bottom: BorderSide(width: 1.0, color: thinGreyColor), // 아래쪽 실선
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "성별이 무엇인가요?",
            style: TextStyle(
              color: blackColor,
              fontSize: 14.0,
              fontWeight: fontWeightMedium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 46,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: setGenderToMale,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.3, 46),
                    backgroundColor: dogGender == '수컷' ? mainColor : whiteColor,
                    foregroundColor: dogGender == '수컷' ? whiteColor : mainColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: dogGender == '수컷' ? transparentColor : mainColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "남",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: setGenderToFemale,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.3, 46),
                    backgroundColor: dogGender == '암컷' ? mainColor : whiteColor,
                    foregroundColor: dogGender == '암컷' ? whiteColor : mainColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: dogGender == '암컷' ? transparentColor : mainColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "여",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: ElevatedButton(
                    onPressed: setIsNeutered,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isNeutered == true ? mainColor : lightGreyColor,
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
                const SizedBox(
                  width: 6,
                ),
                const Baseline(
                  baselineType: TextBaseline.alphabetic,
                  baseline: 15,
                  child: Text(
                    "중성화를 했어요!",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                        fontWeight: fontWeightMedium),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
