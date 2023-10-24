import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class DogBirthInputField extends StatelessWidget {
  const DogBirthInputField({
    super.key,
    required this.selectedDogBirth,
    required this.onChanged,
  });

  final DateTime? selectedDogBirth;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    // 화면 너비
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "생일이 언제인가요?",
            style: TextStyle(
              color: blackColor,
              fontSize: 14.0,
              fontWeight: fontWeightMedium,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: whiteColor,
                      height: 300,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime value) {
                          onChanged(value);
                        },
                        initialDateTime: DateTime(2010, 1, 1),
                        maximumDate: DateTime.now(),
                      ),
                    ),
                  );
                },
                barrierDismissible: true,
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth * 0.9, 46),
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
              backgroundColor: transparentColor,
              foregroundColor:
                  selectedDogBirth != null ? blackColor : mediumGreyColor,
              shadowColor: transparentColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: lightGreyColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  selectedDogBirth == null
                      ? "생일 선택"
                      : selectedDogBirth.toString().split(" ")[0],
                  style: const TextStyle(
                    fontWeight: fontWeightRegular,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
