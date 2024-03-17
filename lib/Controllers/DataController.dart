import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:locationsearch/Apis/GetLocationWeather.dart';
import 'package:locationsearch/Apis/OpenWeatherApi.dart';

class DataController extends GetxController {
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  double? lon;
  double? lat;
  var currentWeather = 0.obs;
  var longitude = RxDouble(0.0);
  var latitude = RxDouble(0.0);
  RxBool isVisible = false.obs;
  // var count = 0.obs;
  // increment() => count++;

  void toggleVisibility() {
    isVisible.toggle();
  }

  Future<void> getLocation() async {
    final permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getLocationData();
    } else {
      fetchWeatherByIP();
    }
  }

  Future<void> getLocationData() async {
    try {
      LocationData locationData = await Location().getLocation();
      lat = locationData.latitude;
      lon = locationData.longitude;
      latitude.value = locationData.latitude!;
      longitude.value = locationData.longitude!;
      await fetchWeather();
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> fetchWeatherByIP() async {
    try {
      final data = await GetLocationWeather.getDetails();
      lon = double.parse(data[0]);
      lat = double.parse(data[1]);
      latitude.value = double.parse(data[0]);
      longitude.value = double.parse(data[1]);
      await fetchWeather();
    } catch (e) {
      print('Error fetchWeatherByIP');
    }
  }

  Future<void> fetchWeather() async {
    try {
      var openres = await OpenWeatherApi.getCurrentTemp(lon!, lat!);

      currentWeather.value = openres.main!.temp!.round();
      toggleVisibility();
    } catch (e) {
      print('Error fetchWeather');
    }
    // (openres.main!.temp!.round().toString() + " °C") as RxString;
    // notifyListeners(); // Notify listeners using provider
  }
}
