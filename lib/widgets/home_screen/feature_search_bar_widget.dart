import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 홈 화면 기능 검색 바
class FeatureSearchBar extends StatelessWidget {
  const FeatureSearchBar({
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
            // TODO: 실제 사용자 이름으로 변경해야 함
            child: Text(
              "Hi, 미키",
              style: TextStyle(
                fontSize: 16,
                fontWeight: fontWeightBold,
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
                            BorderSide(width: 1, color: transparentColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: transparentColor),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: deepPurpleColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                  constraints: const BoxConstraints(),
                  iconSize: 24,
                  // TODO: 검색 기능 구현해서 붙여야 함
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
