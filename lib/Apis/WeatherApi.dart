import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApi {
  static Future<String> getWeatherReport(
      double lon, double lat, String startDate, String endDate) async {
    try {
      Response response = await Dio().get(
        dotenv.env['WeatherEndPoint']!,
        queryParameters: {
          'lon': lon,
          'lat': lat,
          'startDate': startDate,
          'endDate': endDate
        },
      );

      Map<String, dynamic> data = json.decode(response.data);

      // Initialize weather condition
      String weatherCondition = '';

      // Access sunnyDays and perform desired operations
      List<dynamic> summaries =
          data['value'][0]['responses'][0]['weather'][0]['summaries'];
      for (var summary in summaries) {
        int sunnyDays = summary['sunnyDays'];
        if (sunnyDays > 0) {
          weatherCondition += "Sunny, ";
        }
        if (summary['rainyOrSnowyDays'] > 0) {
          weatherCondition += 'Rainy and Snowy, ';
        }
      }

      // Remove the trailing comma and space
      if (weatherCondition.isNotEmpty) {
        weatherCondition =
            weatherCondition.substring(0, weatherCondition.length - 2);
      }

      return weatherCondition.isEmpty
          ? "No specific weather condition"
          : weatherCondition;
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching weather report: $e");
      return "error";
    }
  }
}
