import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CountryInfo {
  final String name;
  final double latitude;
  final double longitude;
  final String famousPlace;
  final String countryCode;

  CountryInfo({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.famousPlace,
    required this.countryCode,
  });
}

class MostPopularCitiesPage extends StatelessWidget {
  final CountryInfo country;
  final void Function(CountryInfo) onTap;

  const MostPopularCitiesPage({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          onTap(country); // Call the onTap callback with the country info
        },
        child: Row(
          children: [
            CountryFlag.fromCountryCode(
              country.countryCode,
              height: 20,
              width: 30,
              borderRadius: 3,
            ),
            SizedBox(
              width: 10,
            ),
            Text(country.name + " , " + country.famousPlace)
          ],
        ),
      ),
    );
  }
}
