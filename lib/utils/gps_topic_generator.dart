import 'dart:ffi';
import 'dart:math';

class Coord {
  double lat;
  double lng;

  Coord(this.lat, this.lng);
}

class Person {
  String name;
  String id;
  String description;
  String imagePath;
  Coord location;

  Person(this.name, this.id, this.description, this.imagePath, this.location);
}

class RandomPersonGenerator {
  static int _maxPerson = 200;
  static List<String> nameList = [
    "김",
    "이",
    "박",
    "최",
    "정",
    "강",
    "조",
    "윤",
    "장",
    "임"
  ];
  static double lat = 37.569700;
  static double lng = 126.977000;

  static List<Person> generateRandomPersonList() {
    List<Person> personList = <Person>[];
    for (int i = 0; i < _maxPerson; i++) {
      personList.add(generateRandomPerson(i));
    }
    return personList;
  }

  static Person generateRandomPerson(int index) {
    // Random random = Random();
    // double randomCoordSalt = random.nextInt(10000) * 0.00001;

    double randomCoordSalt = index * 0.001;

    return Person(
        nameList[index % 8] + index.toString(),
        "id_$index",
        "Hello ${nameList[index % 8]}",
        "assets/images/test/icon-${(index % 8) + 1}.png",
        Coord(lat + randomCoordSalt, lng + randomCoordSalt));
  }
}
