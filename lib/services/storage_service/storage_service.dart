import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage();

  // private한 생성자 생성 => public 생성자가 없어짐
  StorageService._privateConstructor();
  static final StorageService _instance = StorageService._privateConstructor();

  factory StorageService() {
    return _instance;
  }

  Future<String?> getValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future setValue({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future deleteValue({required String key}) async {
    await storage.delete(key: key);
  }

  Future deleteAllValues() async {
    await storage.deleteAll();
  }
}
