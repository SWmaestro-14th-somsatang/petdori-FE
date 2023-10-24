import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyoungsoo/utils/constants.dart';

class DogBirthInputField extends StatelessWidget {
  const DogBirthInputField({
    super.key,
    required String label,
    required String hintText,
    required Function onChanged,
  })  : _label = label,
        _hintText = hintText,
        _onChanged = onChanged;

  final String _label, _hintText;
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
          Text(
            _label,
            style: const TextStyle(
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
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: _hintText,
                hintStyle: const TextStyle(color: mediumGreyColor),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: mainColor),
                ),
                enabledBorder: const OutlineInputBorder(
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
