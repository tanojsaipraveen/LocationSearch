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
      if (response.data['lat'] is String && response.data['lon'] is String) {
        String lat = response.data['lat'].toString();
        String lon = response.data['lon'].toString();
        res = [lat, lon];
      }

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
      return await getAddress(ip);
    } catch (e) {
      print("Error fetching weather report: $e");
      return res;
    }
  }
}
