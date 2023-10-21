import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 회원가입 시 사용되는 텍스트 필드 위젯
///
/// [_label] 텍스트 필드 위젯의 라벨
/// [_hintText] 텍스트 필드 위젯의 힌트 텍스트(placeholer)
/// [_onChanged] 텍스트 필드 위젯의 텍스트가 변경될 때 실행될 콜백 함수
class SignupTextField extends StatelessWidget {
  const SignupTextField({
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ]'))
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
