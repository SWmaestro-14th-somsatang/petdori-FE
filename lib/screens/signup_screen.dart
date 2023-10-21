import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/profile_image_picker_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_button_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_email_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/signup_text_field_widget.dart';

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
/// [_neuteredTypes] 강아지 중성화 여부로 선택가능한 목록
/// [_userName], [_dogName], [_dogType], [_dogGender], [_isNeutered], [_dogAge] 유저가 입력하는 값
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
                ProfileImagePickerButton(
                  setImage: setImage,
                  profileImage: _profileImage,
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                SignupEmailField(
                  email: email,
                  provider: resourceServerName,
                ),
                SignupTextField(
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
                    print("서비스 이용약관");
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
                  child: SignupButton(
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

class PolicyAgreeWidget extends StatelessWidget {
  const PolicyAgreeWidget({
    super.key,
    required this.screenWidth,
    required this.policyName,
    required this.isAgree,
    required this.handleAgree,
    required this.showPolicy,
  });

  final String policyName;
  final bool isAgree;
  final double screenWidth;
  final VoidCallback handleAgree, showPolicy;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.03,
              right: screenWidth * 0.015,
            ),
            child: SizedBox(
              width: 20,
              height: 20,
              child: ElevatedButton(
                onPressed: handleAgree,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAgree ? mainColor : lightGreyColor,
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
          ),
          Baseline(
            baselineType: TextBaseline.alphabetic,
            baseline: 14,
            child: Text(
              policyName,
              style: TextStyle(
                fontSize: 14,
                color: isAgree ? blackColor : mediumGreyColor,
                fontWeight: fontWeightMedium,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: showPolicy,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: isAgree ? blackColor : darkGreyColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class AllPolicyAgreeWidget extends StatelessWidget {
  const AllPolicyAgreeWidget({
    super.key,
    required this.screenWidth,
    required this.isAgreeTerms,
    required this.isAgreePrivacy,
    required this.handleAllAgree,
  });
  final bool isAgreeTerms, isAgreePrivacy;
  final double screenWidth;
  final VoidCallback handleAllAgree;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.only(top: 20),
      height: 50,
      decoration: BoxDecoration(
        color: isAgreeTerms && isAgreePrivacy ? lightBlueColor : lightGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
            ),
            child: SizedBox(
              width: 26,
              height: 26,
              child: ElevatedButton(
                onPressed: handleAllAgree,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAgreeTerms && isAgreePrivacy
                      ? mainColor
                      : mediumGreyColor,
                  fixedSize: const Size(30, 30),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  shadowColor: Colors.transparent,
                ),
                child: const Icon(
                  Icons.check,
                  color: whiteColor,
                  size: 18,
                ),
              ),
            ),
          ),
          Baseline(
            baselineType: TextBaseline.alphabetic,
            baseline: 21,
            child: Text(
              "전체 동의",
              style: TextStyle(
                  color: isAgreeTerms && isAgreePrivacy
                      ? mainColor
                      : mediumGreyColor,
                  fontSize: 16,
                  fontWeight: fontWeightBold,
                  height: 2.0,
                  leadingDistribution: TextLeadingDistribution.even),
            ),
          ),
        ],
      ),
    );
  }
}
