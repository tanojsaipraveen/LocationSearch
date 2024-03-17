import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locationsearch/Models/NearByModel.dart';
import 'package:hive/hive.dart';

class NearbyApi {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    "X-Rapidapi-Host": "travel-advisor.p.rapidapi.com",
    "X-Rapidapi-Key": dotenv.env['RapidapiKey'],
  };

  static Future<NearbyModel> getNearByPlaces(double lon, double lat) async {
    try {
      final cacheBox = await Hive.openBox('api_cache');
      final key = 'nearby_${lon}_${lat}';

      final cachedData = cacheBox.get(key);
      if (cachedData != null) {
        return NearbyModel.fromJson(json.decode(cachedData));
      }

      dio.options.headers.addAll(headers);
      Response response = await dio.get(
        dotenv.env['TravelEndPoint']!,
        queryParameters: {
          'tr_longitude': lon,
          'tr_latitude': lat,
          'bl_latitude': lat + 1.00,
          'bl_longitude': lon + 1.00,
        },
      );

      if (response.statusCode == 200) {
        NearbyModel nearbyData = NearbyModel.fromJson(response.data);
        _optimizeNearbyData(nearbyData);
        cacheBox.put(key, json.encode(nearbyData.toJson()));
        return nearbyData;
      } else {
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      throw Exception('Failed to load nearby places');
    }
  }

  static void _optimizeNearbyData(NearbyModel nearbyData) {
    if (nearbyData.data.length > 16) {
      nearbyData.data.removeAt(15);
    }
    if (nearbyData.data.length > 7) {
      nearbyData.data.removeAt(6);
    }
  }
}
