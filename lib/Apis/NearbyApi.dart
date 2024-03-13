import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:locationsearch/Models/NearByModel.dart';
import 'package:hive/hive.dart';

class NearbyApi {
  static Dio dio = Dio();

  static Future<NearbyModel> getNearByPlaces(double lon, double lat) async {
    try {
      final cacheBox = await Hive.openBox('api_cache');

      final key = 'nearby_${lon}_${lat}';
      // cacheBox.delete(key);
      final cachedData = cacheBox.get(key);

      if (cachedData != null) {
        // Return cached data if available
        return NearbyModel.fromJson(json.decode(cachedData));
      }

      Map<String, dynamic> headers = {
        "X-Rapidapi-Host": "travel-advisor.p.rapidapi.com",
        "X-Rapidapi-Key": "1fff79e649msh165dde9163a3ac6p1417aejsn37fe38b698c3",
      };
      dio.options.headers.addAll(headers);
      Response response = await dio.get(
        'https://travel-advisor.p.rapidapi.com/attractions/list-in-boundary',
        queryParameters: {
          'tr_longitude': lon,
          'tr_latitude': lat,
          'bl_latitude': lat + 1.00,
          'bl_longitude': lon + 1.00,
        },
      );

      if (response.statusCode == 200) {
        NearbyModel nearbyData = NearbyModel.fromJson(response.data);
        if (nearbyData.data.length > 16) {
          nearbyData.data.removeAt(15);
        }
        if (nearbyData.data.length > 7) {
          nearbyData.data.removeAt(6);
        }
        cacheBox.put(key, json.encode(response.data));

        ///cacheBox.put(key, nearbyData.toJson());

        return nearbyData;
      } else {
        // If the response is not successful, throw an exception
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      // Handle errors by throwing an exception
      print("Error fetching nearby places: $e");
      throw Exception('Failed to load nearby places');
    }
  }
}
