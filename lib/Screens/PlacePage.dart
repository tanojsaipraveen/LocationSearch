import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locationsearch/Models/PlaceLocationModel.dart';
import 'package:locationsearch/widgets/LocationButton.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlacePage extends StatefulWidget {
  //final PlaceLocationModel placeLocationModel;
  final String name;
  final String image;
  final String address;
  final String latitude;
  final String longitude;
  final String rating;
  final String description;
  const PlacePage(
      {super.key,
      required this.name,
      required this.image,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.description,
      required this.rating});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 28,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.image,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                placeholder: (context, url) =>
                    Image.asset('assets/images/placeholder.png'),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(alignment: Alignment.topLeft, child: Text(widget.address)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                      child: Image.asset('assets/images/star1.png'),
                    ),
                    const SizedBox(width: 5),
                    Text(widget.rating.toString()),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.description),
              // LocationButton(
              //     latitude: double.parse(widget.latitude),
              //     longitude: double.parse(widget.longitude))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          // isExtended: true,
          // icon: Transform.rotate(angle: 0, child: Icon(Icons.directions)),
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.directions),
          onPressed: () {
            MapUtils.openMap(
                double.parse(widget.latitude), double.parse(widget.longitude));
          },
          label: Text("Direction"),
        ));
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
