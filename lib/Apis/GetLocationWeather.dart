import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetLocationWeather {
  static Future<String> getipaddress() async {
    try {
      Response response = await Dio().get(dotenv.env['GetIpEndPoint']!);
      return response.data;
    } catch (e) {
      return "error";
    }
  }

  static Future<List<String>> getAddress(String ip) async {
    List<String> res = [];
    try {
      Response response = await Dio().get(dotenv.env['GetLocEndPoint']! + ip);

      // Ensure data['lat'] and data['lon'] are strings before adding them to the list
      if (response.data['lat'] != null && response.data['lon'] != null) {
        res = [
          response.data['lon'].toString(),
          response.data['lat'].toString()
        ];
      }
      return res;
    } catch (e) {
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
      return res;
    }
  }
}
