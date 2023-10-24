import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_weight_input_field_widget.dart';
import 'package:wooyoungsoo/widgets/signup_screen/register_button_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_type_select_field_widget.dart';
import 'package:wooyoungsoo/widgets/common/text_input_field_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_birth_input_field_widget.dart';

import '../widgets/common/image_picker_button_widget.dart';

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

  XFile? _dogImage;
  String? _dogName, _dogType, _dogGender;
  bool? _isNeutered;
  int? _dogAge;
  bool _isReady = false;

  void setImage(XFile pickedFile) {
    setState(() {
      _dogImage = XFile(pickedFile.path);
    });
  }

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
                  height: screenHeight * 0.025,
                ),
                ImagePickerButton(
                  setImage: setImage,
                  image: _dogImage,
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                TextInputField(
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
                DogBirthInputField(
                  label: "생일이 언제인가요?",
                  hintText: "생일 선택",
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
                Container(
                  width: screenWidth * 0.9,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      top:
                          BorderSide(width: 1.0, color: thinGreyColor), // 위쪽 실선
                      bottom: BorderSide(
                          width: 1.0, color: thinGreyColor), // 아래쪽 실선
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "성별이 무엇인가요?",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14.0,
                          fontWeight: fontWeightMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 46,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(screenWidth * 0.3, 46),
                                backgroundColor:
                                    _isReady ? mainColor : whiteColor,
                                foregroundColor:
                                    _isReady ? whiteColor : mainColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color:
                                        _isReady ? transparentColor : mainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "남",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(screenWidth * 0.3, 46),
                                backgroundColor:
                                    _isReady ? mainColor : whiteColor,
                                foregroundColor:
                                    _isReady ? whiteColor : mainColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color:
                                        _isReady ? transparentColor : mainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "여",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 24,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      1 == 1 ? mainColor : lightGreyColor,
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
                            const SizedBox(
                              width: 6,
                            ),
                            const Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: 15,
                              child: Text(
                                "중성화를 했어요!",
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 14,
                                    fontWeight: fontWeightMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                DogWeightInputField(onChanged: () {}),
                DogTypeSelectField(
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 60,
                  ),
                  child: RegisterButton(
                    buttonText: "등록하기",
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
