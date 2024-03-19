import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locationsearch/Models/PlaceLocationModel.dart';
import 'package:locationsearch/widgets/LocationButton.dart';
import 'package:palette_generator/palette_generator.dart';
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
  Color? _iconColor;

  @override
  void initState() {
    super.initState();
    _updateIconColor();
  }

  Future<void> _updateIconColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.image),
      size: Size(200, 200), // Adjust as per your image size
    );

    // Get the dominant color from the generated palette
    Color? dominantColor = paletteGenerator.dominantColor?.color;

    // Determine the brightness of the dominant color
    Brightness brightness =
        ThemeData.estimateBrightnessForColor(dominantColor ?? Colors.white);

    // Choose the icon color based on the brightness
    if (brightness == Brightness.light) {
      // If the background is light, use black icon color
      _iconColor = Colors.black;
    } else {
      // Otherwise, use white icon color
      _iconColor = Colors.white;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: _iconColor,
                  size: 28,
                )),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 2.5,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/placeholder.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.address,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          )),
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
                    ],
                  ),
                )
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
            icon: Icon(Icons.map),
            onPressed: () {
              MapUtils.openMap(double.parse(widget.latitude),
                  double.parse(widget.longitude));
            },
            label: Text("View map"),
          )),
    );
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
