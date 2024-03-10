import 'package:hive_flutter/hive_flutter.dart';

class LocalRepo {
  static Future<void> insertRecentSearch(dynamic data) async {
    var box = await Hive.openBox('testBox');
    box.clear();
    box.put('name', data[0]);
    box.put('location', data[1]);
    box.put('pincode', data[2][0]);
    print(
        'Name: ${box.get('name')} - location: ${box.get('location')} - pincode: ${box.get('pincode')}');
  }
}
