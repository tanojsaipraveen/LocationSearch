import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationButton extends StatelessWidget {
  final double latitude;
  final double longitude;

  LocationButton({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _openLocationInMap(latitude, longitude);
        },
        icon: Transform.rotate(angle: 45, child: Icon(Icons.navigation)));
  }

  // Function to open the location in the map application
  _openLocationInMap(double latitude, double longitude) async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    MapUtils.openMap(latitude, longitude);
    // if (await canLaunchUrlString(url)) {
    //   await launchUrlString(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

class MapUtils {
  MapUtils._();
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
