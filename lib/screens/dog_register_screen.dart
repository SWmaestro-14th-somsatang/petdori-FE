import 'package:flutter/material.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_drop_down_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_text_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_number_field_widget.dart';

/// 회원가입 화면
class DogRegisterScreen extends StatefulWidget {
  const DogRegisterScreen({Key? key}) : super(key: key);

  @override
  State<DogRegisterScreen> createState() => _DogRegisterScreenState();
}

/// 회원가입 화면의 state
///
/// [_dogTypes] 강아지 종류로 선택가능한 목록
/// [_genderTypes] 강아지 성별로 선택가능한 목록
/// [_neuteredTypes] 강아지 중성화 여부로 선택가능한 목록
/// [_userName], [_dogName], [_dogType], [_dogGender], [_isNeutered], [_dogAge] 유저가 입력하는 값
/// [_isReady] 모든 필드가 입력되었는지 여부
class _DogRegisterScreenState extends State<DogRegisterScreen> {
  AuthService authService = AuthService();

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
  final List<String> _neuteredTypes = ['중성화함', '중성화하지 않음'];

  String? _dogName, _dogType, _dogGender;
  bool? _isNeutered;
  int? _dogAge;
  bool _isReady = false;

  /// 모든 필드가 입력됐는지 체크하는 메서드
  bool areAllFieldFilled() {
    return _dogName != null &&
        _dogType != null &&
        _dogGender != null &&
        _isNeutered != null &&
        _dogAge != null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      appBar: AppBar(
        leading: const GoBackButton(),
        backgroundColor: screenBackgroundColor,
        shadowColor: transparentColor,
        shape: const Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "새 반려견 등록",
          style: TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: fontWeightBold,
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
                  height: screenHeight * 0.05,
                ),
                SignupTextField(
                  label: '이름이 무엇인가요?',
                  hintText: '이름 입력',
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
                  width: screenWidth * 0.9,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        width: screenWidth * 0.425,
                      ),
                      SignupDropDownField(
                        label: "중성화 여부",
                        items: _neuteredTypes,
                        onChanged: (value) {
                          setState(() {
                            _isNeutered =
                                value == _neuteredTypes[0] ? true : false;
                            if (areAllFieldFilled()) {
                              _isReady = true;
                              return;
                            }
                            _isReady = false;
                          });
                        },
                        width: screenWidth * 0.425,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: SignupButton(
                    isReady: _isReady,
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        "dog_name": _dogName,
                        "dog_type": _dogType,
                        "dog_gender": _dogGender,
                        "is_neutered": _isNeutered,
                        "dog_age": _dogAge,
                      };

                      debugPrint("clicked!");
                    },
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
