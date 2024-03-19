import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:locationsearch/Models/OpenWeatherModel.dart';

class OpenWeatherApi {
  static final Dio dio = Dio();
  static Future<OpenWeatherModel> getCurrentTemp(double lon, double lat) async {
    try {
      final cacheBox = await Hive.openBox('api_cache');
      final key = 'open_${lon}_${lat}';

      final cachedData = cacheBox.get(key);
      if (cachedData != null) {
        return OpenWeatherModel.fromJson(json.decode(cachedData));
      }

      Response response = await dio.get(
        dotenv.env['OpenWeatherApiEndPoint']!,
        queryParameters: {
          'lon': lon,
          'lat': lat,
          'appid': dotenv.env['OpenWeatherKey'],
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        OpenWeatherModel openWeatherModel =
            OpenWeatherModel.fromJson(response.data);
        cacheBox.put(key, json.encode(openWeatherModel.toJson()));
        return openWeatherModel;
      } else {
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      throw Exception('Failed to load nearby places');
    }
  }
}
