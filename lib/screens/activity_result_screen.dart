import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyoungsoo/models/dog_detail_model.dart';
import 'package:wooyoungsoo/models/profile_model.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/services/dog_service/dog_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/console/walk_stats_grid_widget.dart';
import 'package:wooyoungsoo/widgets/activity/walk/session/map/map_widget.dart';

class ActivityResultScreen extends StatefulWidget {
  const ActivityResultScreen({super.key});

  @override
  State<ActivityResultScreen> createState() => _ActivityResultScreenState();
}

class _ActivityResultScreenState extends State<ActivityResultScreen> {
  final AuthService authService = AuthService();
  final DogService dogService = DogService();
  // final DogLogService dogLogService = DogLogService();
  late ProfileModel? profile;
  late List<DogDetailModel> myDogs;
  bool isLoading = true;
  XFile? _image;
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

  void setImage(XFile pickedFile) {
    setState(() {
      _image = XFile(pickedFile.path);
    });
  }

  Future loadProfileAndDogs() async {
    profile = await authService.getProfile();
    myDogs = await dogService.getMyDogs();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfileAndDogs();
  }

  @override
  Widget build(BuildContext context) {
    // final ActivityResultScreenArguments args =
    //     ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "산책 결과",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateTime.now().toString().substring(0, 16),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "🎉고생하셨어요!\n산책 결과는 다음과 같아요",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              // 산책 지도
              const SizedBox(
                width: 500,
                height: 200,
                child: MapWidget(),
              ),
              // const SizedBox(
              //   width: 400,
              //   height: 200,
              //   child: Image(
              //     image: AssetImage('assets/data/walk_res.png'),
              //   ),
              // ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const WalkStatsGridWidget(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "함께 산책한 강아지들",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // 강아지 리스트 위젯
              (isLoading)
                  ? const Text("로딩중")
                  : (myDogs.isEmpty)
                      ? const Text("강아지가 없습니다.")
                      : DogListWidget(myDogs: myDogs),
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "오늘의 산책을\n사진으로 남겨볼까요?📷",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),

              (_image != null)
                  ? Container(
                      width: 500,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: FileImage(
                            File(_image!.path),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox(width: 10),
              const Padding(padding: EdgeInsets.only(top: 0, bottom: 20)),
              // 사진 업로드 버튼
              ElevatedButton(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 50),
                  padding: EdgeInsets.zero,
                  backgroundColor: lightGreyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.transparent,
                ),
                child: _image != null
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 28,
                            color: darkGreyColor,
                          ),
                          SizedBox(width: 5),
                          Text("다시 찍기",
                              style:
                                  TextStyle(fontSize: 18, color: blackColor)),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 28,
                            color: darkGreyColor,
                          ),
                          SizedBox(width: 5),
                          Text("사진 찍기",
                              style:
                                  TextStyle(fontSize: 18, color: blackColor)),
                        ],
                      ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
              // 서버에 저장하기 버튼
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 50),
                  padding: EdgeInsets.zero,
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.transparent,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("저장하기",
                        style: TextStyle(
                            fontSize: 18,
                            color: whiteColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DogListWidget extends StatelessWidget {
  const DogListWidget({super.key, required this.myDogs});

  final List<DogDetailModel> myDogs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: myDogs.length * 60,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: myDogs.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: myDogs[index].dogImageUrl == null
                    ? const AssetImage(
                        "assets/images/default_dog_image.png",
                      )
                    : NetworkImage(myDogs[index].dogImageUrl!) as ImageProvider,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myDogs[index].dogName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "약 130kcal 소모",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 0,
          height: 10,
        ),
      ),
    );
  }
}
