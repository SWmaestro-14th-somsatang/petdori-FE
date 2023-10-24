import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class DogWeightInputField extends StatelessWidget {
  const DogWeightInputField({
    super.key,
    required Function onChanged,
  }) : _onChanged = onChanged;

  final Function _onChanged;

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
            "몸무게가 몇인가요?",
            style: TextStyle(
              color: blackColor,
              fontSize: 14.0,
              fontWeight: fontWeightMedium,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 46,
            child: TextField(
              minLines: null,
              maxLines: null,
              expands: true,
              style: const TextStyle(
                fontSize: 14,
                color: blackColor,
              ),
              textInputAction: TextInputAction.done,
              onChanged: (value) => _onChanged(value),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{1,2}(\.\d{0,1})?$'),
                ),
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: "몸무게 입력 (kg)",
                suffixText: "kg",
                hintStyle: TextStyle(color: mediumGreyColor),
                suffixStyle: TextStyle(color: blackColor),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: mainColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: lightGreyColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
