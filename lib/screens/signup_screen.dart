import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wooyoungsoo/models/base_response_model.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_drop_down_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_text_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_number_field_widget.dart';

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
  final storage = const FlutterSecureStorage();
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
  void signup(String email, String oauth2Provider) async {
    Dio dio = Dio();
    try {
      var res = await dio.post(
        "http://localhost:8080/api/auth/signup?provider=$oauth2Provider",
        data: {
          "email": email,
          "name": _userName,
          "dog_name": _dogName,
          "dog_type": _dogType,
          "dog_gender": _dogGender,
          "dog_age": _dogAge,
        },
      );

      var signupResponse = BaseResponseModel.fromJson(res.data);
      if (signupResponse.status == "success") {
        String accessToken = signupResponse.data["access_token"];
        String refreshToken = signupResponse.data["refresh_token"];

        await storage.write(key: "accessToken", value: accessToken);
        await storage.write(key: "refreshToken", value: refreshToken);

        Navigator.of(context).pushReplacementNamed("/");
        return;
      }
    } on DioException {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 높이
    final double screenHeight = MediaQuery.of(context).size.height;

    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String email = arguments["email"];
    String resourceServerName = arguments["resourceServerName"];

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
          "회원가입",
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
                    onPressed: () => signup(email, resourceServerName),
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
