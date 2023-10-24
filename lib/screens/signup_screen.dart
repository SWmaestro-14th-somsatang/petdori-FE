import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/all_policy_agree_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/policy_agree_widget.dart';
import 'package:wooyoungsoo/widgets/common/image_picker_button_widget.dart';
import 'package:wooyoungsoo/widgets/common/register_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_email_field_widget.dart';
import 'package:wooyoungsoo/widgets/common/text_input_field_widget.dart';

/// 회원가입 화면
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

/// 회원가입 화면의 state
///
/// [_profileImage], [_userName] 유저가 입력하는 값
/// [_isAgreeTerms], [_isAgreePrivacy] 유저가 약관에 동의하는지 여부
/// [_isReady] 모든 필드가 입력되었는지 여부
class _SignupScreenState extends State<SignupScreen> {
  AuthService authService = AuthService();
  XFile? _profileImage;
  String? _userName;
  bool _isAgreeTerms = false;
  bool _isAgreePrivacy = false;
  bool _isReady = false;

  void setImage(XFile pickedFile) {
    setState(() {
      _profileImage = XFile(pickedFile.path);
    });
  }

  /// 모든 필드가 입력됐는지 체크하는 메서드
  bool areAllFieldFilled() {
    return _userName != null && _isAgreeTerms && _isAgreePrivacy;
  }

  void checkReady() {
    if (areAllFieldFilled()) {
      _isReady = true;
      return;
    }
    _isReady = false;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: const Text(
                        "회원가입",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: fontWeightBold,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                ImagePickerButton(
                  setImage: setImage,
                  image: _profileImage,
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                SignupEmailField(
                  email: email,
                  provider: resourceServerName,
                ),
                TextInputField(
                  label: '이름',
                  hintText: '이름 입력',
                  onChanged: (value) {
                    setState(() {
                      _userName = value.isEmpty ? null : value;
                      checkReady();
                    });
                  },
                ),
                Container(
                  height: 4,
                  color: lightGreyColor,
                ),
                AllPolicyAgreeWidget(
                  screenWidth: screenWidth,
                  isAgreeTerms: _isAgreeTerms,
                  isAgreePrivacy: _isAgreePrivacy,
                  handleAllAgree: () {
                    setState(() {
                      if (!_isAgreeTerms || !_isAgreePrivacy) {
                        _isAgreeTerms = true;
                        _isAgreePrivacy = true;
                      } else {
                        _isAgreeTerms = false;
                        _isAgreePrivacy = false;
                      }

                      checkReady();
                    });
                  },
                ),
                PolicyAgreeWidget(
                  policyName: "서비스 이용약관(필수)",
                  isAgree: _isAgreeTerms,
                  screenWidth: screenWidth,
                  handleAgree: () {
                    setState(() {
                      _isAgreeTerms = !_isAgreeTerms;
                      checkReady();
                    });
                  },
                  showPolicy: () {
                    print("서비스 이용약관"); // TODO : 약관 보여주는 페이지로 이동하는 함수를 전달해야 함
                  },
                ),
                PolicyAgreeWidget(
                  policyName: "개인정보 처리방침(필수)",
                  isAgree: _isAgreePrivacy,
                  screenWidth: screenWidth,
                  handleAgree: () {
                    setState(() {
                      _isAgreePrivacy = !_isAgreePrivacy;
                      checkReady();
                    });
                  },
                  showPolicy: () {
                    print("개인정보처리방침");
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 90),
                  child: RegisterButton(
                    buttonText: "가입하기",
                    isReady: _isReady,
                    onPressed: () async {
                      final formData = FormData.fromMap({
                        'email': email,
                        "name": _userName,
                        "profile_image": _profileImage != null
                            ? await MultipartFile.fromFile(
                                _profileImage!.path,
                              )
                            : null,
                      });

                      await authService.signup(
                        context: context,
                        oauth2Provider: resourceServerName,
                        formData: formData,
                      );
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
