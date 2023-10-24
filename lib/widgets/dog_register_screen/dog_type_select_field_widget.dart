import 'package:flutter/material.dart';
import 'package:wooyoungsoo/utils/constants.dart';

/// 견종 선택 시 사용되는 드롭다운 버튼 위젯
///
/// [_items] 드롭다운 버튼 위젯의 아이템 리스트
/// [_onChanged] 드롭다운 버튼 위젯의 아이템 선택 시 실행될 콜백 함수
/// [_width] 드롭다운 버튼 위젯의 너비
class DogTypeSelectField extends StatefulWidget {
  const DogTypeSelectField({
    super.key,
    required List<String>? items,
    required Function onChanged,
    required double width,
  })  : _items = items,
        _onChanged = onChanged,
        _width = width;

  final List<String>? _items;
  final Function _onChanged;
  final double _width;

  @override
  State<DogTypeSelectField> createState() => _DogTypeSelectFieldState();
}

class _DogTypeSelectFieldState extends State<DogTypeSelectField> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget._width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "견종이 무엇인가요?",
            style: TextStyle(
              color: blackColor,
              fontSize: 14.0,
              fontWeight: fontWeightMedium,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: lightGreyColor,
              ),
            ),
            child: DropdownButton(
              hint: const Text(
                "견종 선택",
                style: TextStyle(
                  fontSize: 14,
                  color: mediumGreyColor,
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: blackColor,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_sharp,
              ),
              iconEnabledColor: darkGreyColor,
              underline: Container(
                height: 0,
              ),
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              value: _selectedItem,
              items: widget._items != null
                  ? widget._items!.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList()
                  : null,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value!;
                  widget._onChanged(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
