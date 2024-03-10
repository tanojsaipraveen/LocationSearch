import 'package:dio/dio.dart';
import 'package:locationsearch/Models/NearByModel.dart';

class NearbyApi {
  static Future<NearbyModel?> getNearByPlaces(double lon, double lat) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> headers = {
        "X-Rapidapi-Host": "travel-advisor.p.rapidapi.com",
        "X-Rapidapi-Key": "6f26643bc5msh8bfa02ece65630dp1514d5jsn5b7c486c9eba",
        // Add more headers as needed
      };
      dio.options.headers.addAll(headers);
      Response response = await dio.get(
        'https://travel-advisor.p.rapidapi.com/attractions/list-in-boundary',
        queryParameters: {
          'tr_longitude': lon,
          'tr_latitude': lat,
          'bl_latitude': lat + 1.00,
          'bl_longitude': lon + 1.00
        },
      );

      if (response.statusCode == 200) {
        // If response is successful, return the parsed data
        NearbyModel nearbydata = NearbyModel.fromJson(response.data);
        if (nearbydata.data.length > 16) {
          nearbydata.data.removeAt(6);
          nearbydata.data.removeAt(15);
        }
        return nearbydata;
      } else {
        // If the response is not successful, throw an exception
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching nearby places: $e");
      return null; // Return null or handle the error accordingly
    }
  }
}
