import 'dart:io';

import 'package:image/image.dart';

void main() {
  Image? image =
      decodeImage(File('assets/images/test/icon-1.png').readAsBytesSync());
  Image thumbnail = copyResize(image!, width: 120);
  new File('assets/images/test/out-1.png')
      .writeAsBytesSync(encodePng(thumbnail));
}
