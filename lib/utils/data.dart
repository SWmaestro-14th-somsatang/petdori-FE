import 'dart:io';

class point {
  double lat;
  double lng;
  point(this.lat, this.lng);
}

void main() {
  getCoordsPointData('lib/data/points_0.csv');
}

List<point> getCoordsPointData(String path) {
  // CSV 파일 읽기
  File csvFile = File(path);
  List<String> lines = csvFile.readAsLinesSync();

  // WKT 열의 데이터 추출
  List<point> points = <point>[];
  List<String> headers = lines[0].split(',');
  int wktColumnIndex = headers.indexOf('WKT');

  double lat = 0.0;
  double lng = 0.0;
  for (int i = 1; i < lines.length; i++) {
    List<String> values = lines[i].split(',');
    List<String> tokens = values[wktColumnIndex].split(' ');
    lng = double.parse(tokens[1].substring(1, tokens[1].length));
    lat = double.parse(tokens[2].substring(0, tokens[2].length - 2));
    points.add(point(lat, lng));
  }
  return points;
}
