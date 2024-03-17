import 'package:location/location.dart';
import 'package:locationsearch/Apis/GetLocationWeather.dart';

class LoactionCoordinate {
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<List<String>> fetchLocationData() async {
    final permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      return getLocationData1();
    } else {
      return fetchWeatherByIP1();
    }
  }

  Future<List<String>> fetchWeatherByIP1() async {
    List<String> res = [];
    try {
      final data = await GetLocationWeather.getDetails();

      res.add(data[0]);
      res.add(data[1]);
    } catch (e) {
      print('Error fetchWeatherByIP');
    }
    return res;
  }

  Future<List<String>> getLocationData1() async {
    List<String> res = [];
    try {
      LocationData locationData = await Location().getLocation();
      res.add(locationData.longitude.toString());
      res.add(locationData.latitude.toString());
    } catch (e) {
      print('Error getting location: $e');
    }
    return res;
  }
}
