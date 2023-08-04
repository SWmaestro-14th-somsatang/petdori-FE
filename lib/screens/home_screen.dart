import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 홈 화면
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.033,
        ),
        child: Column(
          children: [
            HomeHeader(screenWidth: screenWidth),
            IntroductoryPhrase(screenWidth: screenWidth),
            const SearchBar(),
            const MainFeatureButtons(),
            AdditionalFeatureButtons(),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade600,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 5,
                ),
                child: Text(
                  "우영수",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroductoryPhrase extends StatelessWidget {
  const IntroductoryPhrase({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.033,
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "우리집 멍·냥이",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "영양 ",
                        style: TextStyle(
                          color: Color(0xFF8889f3),
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansKR",
                        ),
                      ),
                      TextSpan(
                        text: "절대 지켜!!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansKR",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              "Hi, 미키",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: null,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Color(0xFF8f59f5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                  constraints: const BoxConstraints(),
                  iconSize: 24,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainFeatureButtons extends StatelessWidget {
  const MainFeatureButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              "메인 서비스",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 170,
            child: GridView.count(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: const [
                MainFeatureButton(
                  buttonText: "결제",
                  buttonColor: Color(0xFFe9eef1),
                  assetName: "assets/images/cart.svg",
                ),
                MainFeatureButton(
                  buttonText: "사료",
                  buttonColor: Color(0xFFf7efe4),
                  assetName: "assets/images/bone.svg",
                ),
                MainFeatureButton(
                  buttonText: "차트 목록",
                  buttonColor: Color(0xFFe8eaf7),
                  assetName: "assets/images/health_chart.svg",
                ),
                MainFeatureButton(
                  buttonText: "혈당",
                  buttonColor: Color(0xFFf5ecef),
                  assetName: "assets/images/heart_pulse.svg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainFeatureButton extends StatelessWidget {
  const MainFeatureButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.assetName,
  });

  final String buttonText;
  final Color buttonColor;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            child: SvgPicture.asset(assetName),
          ),
          const SizedBox(width: 10),
          Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AdditionalFeatureButtons extends StatelessWidget {
  AdditionalFeatureButtons({
    super.key,
  });

  final List<String> featureImagePaths = [
    "assets/images/dog_walk.svg",
    "assets/images/pet_doctors.svg",
  ];

  final List<String> featureNames = [
    "산책 및 경로 추천",
    "화상 상담",
  ];

  final List<String> descriptions = [
    "같은 동네 사람들이 다녀간 길을 따라 걸어볼까요?",
    "지금 당장 1 : 1 실시간 진료를 받아보세요!",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              "부가 서비스",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: featureNames.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                height: 130,
                child: AdditionalFeatureButton(
                  assetName: featureImagePaths[index],
                  featureName: featureNames[index],
                  description: descriptions[index],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
          ),
        ],
      ),
    );
  }
}

class AdditionalFeatureButton extends StatelessWidget {
  const AdditionalFeatureButton({
    super.key,
    required this.assetName,
    required this.featureName,
    required this.description,
  });

  final String assetName;
  final String featureName;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: SvgPicture.asset(assetName),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    featureName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
