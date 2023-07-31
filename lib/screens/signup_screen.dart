import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_drop_down_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_text_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_number_field_widget.dart';

/// 회원가입 화면
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

/// 회원가입 화면의 state
///
/// [_dogTypes] 강아지 종류로 선택가능한 목록
/// [_genderTypes] 강아지 성별로 선택가능한 목록
/// [_userName], [_dogName], [_dogType], [_dogGender], [_dogAge] 유저가 입력하는 값
/// [_isReady] 모든 필드가 입력되었는지 여부
class _SignupScreenState extends State<SignupScreen> {
  // TODO(Cho-SangHyun): 추후 DB에서 강아지 종류를 받아와야 함
  final List<String> _dogTypes = [
    '프렌치 불독',
    '푸들',
    '시바견',
    '말티즈',
    '치와와',
    '포메라니안',
    '요크셔테리어'
  ];
  final List<String> _genderTypes = ['수컷', '암컷'];

  String? _userName, _dogName, _dogType, _dogGender;
  int? _dogAge;
  bool _isReady = false;

  /// 모든 필드가 입력됐는지 체크하는 메서드
  bool areAllFieldFilled() {
    return _userName != null &&
        _dogName != null &&
        _dogType != null &&
        _dogGender != null &&
        _dogAge != null;
  }

  /// 회원가입 기능을 수행하는 메서드
  void signup() {
    // TODO(Cho-SangHyun): 추후 실제 회원가입 기능 구현해야 함
    Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      appBar: AppBar(
        leading: const GoBackButton(),
        backgroundColor: screenBackgroundColor,
        shadowColor: Colors.transparent,
        shape: const Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "회원가입",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SignupTextField(
                  label: '이름',
                  hintText: '이름을 입력하세요.',
                  onChanged: (value) {
                    setState(() {
                      _userName = value.isEmpty ? null : value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                SignupTextField(
                  label: '강아지 이름',
                  hintText: '강아지 이름을 입력하세요.',
                  onChanged: (value) {
                    setState(() {
                      _dogName = value.isEmpty ? null : value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                SignupNumberField(
                  label: "강아지 나이",
                  hintText: "강아지 나이를 입력하세요.",
                  onChanged: (value) {
                    setState(() {
                      _dogAge = int.tryParse(value);
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                SignupDropDownField(
                  label: "강아지 종류",
                  items: _dogTypes,
                  onChanged: (value) {
                    setState(() {
                      _dogType = value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                SignupDropDownField(
                  label: "강아지 성별",
                  items: _genderTypes,
                  onChanged: (value) {
                    setState(() {
                      _dogGender = value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: SignupButton(
                    isReady: _isReady,
                    onPressed: signup,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
