import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            child: TextField(
              minLines: null,
              maxLines: null,
              expands: true,
              textInputAction: TextInputAction.done,
              onChanged: (value) => _onChanged(value),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ]'))
              ],
              decoration: InputDecoration(
                hintText: _hintText,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
