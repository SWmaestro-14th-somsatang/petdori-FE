import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class point {
  double lat;
  double lng;
  point(this.lat, this.lng);
}

void main() {
  getCoordsPointData('assets/data/points_0.csv');
  getCoordsPointData('assets/data/walkman_1.csv');
  loadCSV('assets/data/points_0.csv');
}

Future<List<List<dynamic>>> loadCSV(String path) async {
  String csvString = await rootBundle.loadString(path);
  // 이제 csvString을 원하는 방식으로 처리할 수 있습니다.

  return const CsvToListConverter().convert(csvString, eol: "\n");
}

Future<List<point>> getCoordsPointData(String path) async {
  // CSV 파일 읽기
  var csvFile = loadCSV(path);
  List<point> points = <point>[];
  double lat = 0.0;
  double lng = 0.0;
  await csvFile.then((value) => {
        value.forEach((element) {
          List<String> tokens = element[0].split(' ');
          lng = double.parse(tokens[1].substring(1, tokens[1].length));
          lat = double.parse(tokens[2].substring(0, tokens[2].length - 2));
          points.add(point(lat, lng));
        }),
      });
  return points;
}
