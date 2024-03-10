import 'package:flutter/material.dart';

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
    // String url =
    //     'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // if (await canLaunchUrlString(url)) {
    //   await launchUrlString(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
