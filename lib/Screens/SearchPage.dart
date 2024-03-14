import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:locationsearch/Models/LocationDataModel.dart' as locationdata;
import 'package:locationsearch/Screens/SearchPage.dart';
import 'package:locationsearch/main.dart';
import 'package:page_transition/page_transition.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<locationdata.LocationDataModel> items = [];

  TextEditingController _controller = TextEditingController();
  String? _location;
  List<double>? _coordinate;
  Timer? _timer;
  Timer? _timer1;
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  void placeAutoComplete(String val) async {
    await locationList(val).then((value) {
      setState(() {
        items = value;
      });
    });
  }

  Future<List<locationdata.LocationDataModel>> locationList(
      String address) async {
    Response response = await Dio().get(dotenv.env['LocationEndpoint'] ?? "",
        queryParameters: {'q': address, "limit": dotenv.env['LocationLimit']});
    final json = response.data;
    return (json['features'] as List)
        .map((e) => locationdata.LocationDataModel.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 4,
                child: TextField(
                  onSubmitted: (value) {
                    Navigator.pop(
                        context, [_controller.text, _location, _coordinate]);
                  },
                  autofocus: true,
                  controller: _controller,
                  onChanged: (val) {
                    _timer1?.cancel();
                    _timer1 = Timer(const Duration(milliseconds: 0), () {
                      if (val.isEmpty) {
                        // Clear the list when the text field is empty
                        items.clear();
                        setState(() {});
                      } else {
                        // Cancel the previous timer if there is any
                        _timer?.cancel();
                        // Start a new timer
                        _timer = Timer(const Duration(milliseconds: 0), () {
                          placeAutoComplete(val);
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_sharp)),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Visibility(
                        //     visible: _controller.text.isEmpty,
                        //     child: IconButton(
                        //         onPressed: () {
                        //           _controller.text = "";
                        //           setState(() {});
                        //         },
                        //         icon: const Icon(Icons.mic))),
                        Visibility(
                            visible: _controller.text.isNotEmpty,
                            child: IconButton(
                                onPressed: () {
                                  _controller.text = "";
                                  items.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close))),
                      ],
                    ),
                    filled: true,
                    prefixIconColor: Theme.of(context).primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust border radius here
                      borderSide: BorderSide.none, // No border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust border radius here
                      borderSide: BorderSide.none, // No border
                    ),
                    hintText: 'Enter Your Destination',
                    hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey, // Adjust the color of the hint text
                        fontWeight: FontWeight
                            .w400 // You can adjust other properties like fontSize, fontWeight, etc.
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: _controller.text.isNotEmpty,
              child: Expanded(
                child: ListView(
                  children: items
                      .map(
                        (e) => ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black12,
                              ),
                              child: const Icon(Icons.place_outlined)),
                          title: Text(e.properties!.name! ?? ""),
                          subtitle: Text(
                              e.properties!.state ?? e.properties!.type! ?? ""),
                          trailing: RotatedBox(
                              quarterTurns: 3,
                              child: IconButton(
                                  onPressed: () {
                                    _controller.text =
                                        e.properties!.name.toString();
                                    placeAutoComplete(
                                        e.properties!.name.toString());
                                    _location = e.properties!.state ??
                                        e.properties!.type!;
                                    _coordinate = e.geometry!.coordinates!;
                                  },
                                  icon: const Icon(Icons.arrow_outward))),
                          onTap: () {
                            print(e.properties!.name);
                            _controller.text = e.properties!.name.toString();
                            items.clear();
                            Navigator.pop(context, [
                              _controller.text,
                              e.properties!.state ?? e.properties!.type!,
                              e.geometry!.coordinates!
                            ]);
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Visibility(
                  visible: _controller.text.isEmpty,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var box = await Hive.openBox('testBox');
                              box.clear();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("clear"),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
