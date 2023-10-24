import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 프로필 & 반려견 이미지를 선택하는 버튼 위젯
///
/// [setImage] 이미지를 선택했을 때 수행할 메서드
/// [image] 이미지 파일
class ImagePickerButton extends StatelessWidget {
  ImagePickerButton({
    super.key,
    required this.setImage,
    required this.image,
  });

  final Function setImage;
  final XFile? image;
  final ImagePicker picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setImage(pickedFile);
      }
    } catch (e) {
      print("접근 권한이 설정되어 있지 않습니다");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        pickImage(ImageSource.gallery);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 120),
        padding: EdgeInsets.zero,
        backgroundColor: lightGreyColor,
        shape: const CircleBorder(),
        shadowColor: Colors.transparent,
      ),
      child: image != null
          ? Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(
                    File(image!.path),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const Icon(
              Icons.camera_alt_rounded,
              size: 28,
              color: darkGreyColor,
            ),
    );
  }
}
