import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locationsearch/Models/WeatherResultModel.dart' as WeatherModel;

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
      var result =
          weatherCondition.isEmpty ? "Mostly Cloudy" : weatherCondition;
      return result;
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching weather report: $e");
      return "error";
    }
  }

  static Future<WeatherModel.WeatherResultModel> getWeatherReportResult(
      double lon, double lat, String startDate, String endDate) async {
    try {
      Response response1 = await Dio().get(
        dotenv.env['WeatherEndPoint']!,
        queryParameters: {
          'lon': lon,
          'lat': lat,
          'startDate': startDate,
          'endDate': endDate
        },
      );

      if (response1.statusCode == 200) {
        String responseData = response1.data;
        Map<String, dynamic> data1 = json.decode(responseData);
        WeatherModel.WeatherResultModel weatherModel =
            WeatherModel.WeatherResultModel.fromJson(data1);

        return weatherModel;
      } else {
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      // Handle errors appropriately

      print("Error fetching weather report: $e");
      throw Exception('Failed to load nearby places');
    }
  }
}
