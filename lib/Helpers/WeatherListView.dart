import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locationsearch/Apis/WeatherApi.dart';
import 'package:locationsearch/Models/WeatherResultModel.dart';

class WeatherListView extends StatelessWidget {
  final double lon;
  final double lat;
  final String startDate;
  final String endDate;

  const WeatherListView({
    required this.lon,
    required this.lat,
    required this.startDate,
    required this.endDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Report'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<WeatherResultModel>(
            future: WeatherApi.getWeatherReportResult(
              lon,
              lat,
              startDate,
              endDate,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              } else if (snapshot.hasError) {
                return Text("Error");
              } else if (snapshot.hasData) {
                final weatherResult = snapshot.data!;
                return _buildWeatherCard(weatherResult);
              } else {
                return Text("Error");
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Card(
      child: Container(
        width: 80,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorCard() {
    return Card(
      child: Container(
        width: 80,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text('Error'),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherResultModel weatherResult) {
    // Use weatherResult data to build the card
    return Card(
      child: Container(
        width: 80,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 40,
                child: SvgPicture.network(
                  'https://assets.msn.com/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HazySmokeV2.svg',
                  semanticsLabel: 'Weather Icon',
                  placeholderBuilder: (BuildContext context) =>
                      CircularProgressIndicator(),
                ),
              ),
            ),
            Text(
              "16/5",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            Positioned(
              right: 0,
              child: Text(
                "23°",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                "13°",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
