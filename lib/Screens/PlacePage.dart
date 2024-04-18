import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  int _index = 0;
  String textToShow = '';
  Color? _iconColor;
  Color? _circleColor;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _startTyping();
    _updateIconColor();
  }

  void _startTyping() {
    final text = widget.description;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (_index < text.length) {
          textToShow = text.substring(0, _index + 1);
          _index++;
        } else {
          timer.cancel();
        }
      });
      _controller.animateTo(
        _controller.position.viewportDimension + 20,
        duration: Duration(milliseconds: 10),
        curve: Curves.easeOut,
      );
    });
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
      _circleColor = Colors.white54;
    } else {
      // Otherwise, use white icon color
      _iconColor = Colors.white;
      _circleColor = Colors.black54;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: _circleColor, borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.arrow_back,
                color: _iconColor,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment(0.0, 0.3),
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/placeholder.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        textToShow,
                        style: TextStyle(height: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //isExtended: true,
        // icon: Transform.rotate(angle: 0, child: Icon(Icons.directions)),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.map),
        onPressed: () {
          MapUtils.openMap(
              double.parse(widget.latitude), double.parse(widget.longitude));
        },
        label: Text(
          "View map",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        extendedPadding: EdgeInsets.symmetric(horizontal: 80),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
