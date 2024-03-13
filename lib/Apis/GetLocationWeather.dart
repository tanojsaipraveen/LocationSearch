import 'dart:convert';

import 'package:dio/dio.dart';

class GetLocationWeather {
  static Future<String> getipaddress() async {
    try {
      Response response = await Dio().get('https://api.ipify.org');
      print(response.data);
      return response.data;
    } catch (e) {
      print("Error fetching weather report: $e");
      return "error";
    }
  }

  static Future<List<String>> getAddress(String ip) async {
    List<String> res = [];
    try {
      Response response = await Dio().get('http://ip-api.com/json/$ip');
      print(response.data['lat']);
      print(response.data['lon']);

      // Ensure data['lat'] and data['lon'] are strings before adding them to the list
      if (response.data['lat'] != null && response.data['lon'] != null) {
        res = [
          response.data['lon'].toString(),
          response.data['lat'].toString()
        ];
      }
      print("tanoj");
      print(res);
      return res;
    } catch (e) {
      print("Error fetching weather report: $e");
      return res;
    }
  }

  static Future<List<String>> getDetails() async {
    List<String> res = [];
    try {
      String ip = await getipaddress();
      res = await getAddress(ip);
      return res;
    } catch (e) {
      print("Error fetching weather report: $e");
      return res;
    }
  }
}
