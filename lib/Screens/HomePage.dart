import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:locationsearch/Apis/NearbyApi.dart';
import 'package:locationsearch/Apis/WeatherApi.dart';
import 'package:locationsearch/DB/LocalRepo.dart';
import 'package:locationsearch/Helpers/HelperMethods.dart';
import 'package:locationsearch/Models/LocationDataModel.dart' as locationdata;
import 'package:locationsearch/Models/NearByModel.dart';
import 'package:locationsearch/Screens/LoginPage.dart';
import 'package:locationsearch/Screens/RegisterPage.dart';
import 'package:locationsearch/Screens/SearchPage.dart';
import 'package:locationsearch/widgets/CounterWidgets.dart';
import 'package:locationsearch/widgets/LocationButton.dart';
import 'package:locationsearch/widgets/TextFieldWidget.dart';
import 'package:locationsearch/widgets/TravelActivitySelector.dart';
import 'package:page_transition/page_transition.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<locationdata.LocationDataModel> items = [];
  dynamic returndata;
  bool isDataAviable = false;
  bool isResultAviable = false;
  String? weatherReportResult;
  bool isNearbyDataAvaliable = false;
  final DateTime today = DateTime.now();
  NearbyModel? nearbydata;
  int selectedTrip = 0;
  final List<String> travelActivities = [
    'Sightseeing',
    'Hiking and Trekking',
    'Cultural Tours',
    'Swing',
    'Cool'
  ];
  Widget customRadio(String text, int index) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: (selectedTrip == index)
              ? Theme.of(context).primaryColor
              : Colors.white,
        ),
        onPressed: () {
          setState(() {
            selectedTrip = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: (selectedTrip == index) ? Colors.white : Colors.black),
        ));
  }

  TextEditingController _controller = TextEditingController();
  DateTimeRange selectedDates = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 2)));

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final start = selectedDates.start;
    final end = selectedDates.end;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                            Text(
                              "Tanojsaipraveen",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                                width: 30,
                                child: Image.asset("assets/images/cloudy.png")),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "25° C",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, top: 10),
                      child: Card(
                        elevation: 4,
                        child: TextField(
                          readOnly: true,
                          onTap: () async {
                            final dynamic data = await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const SearchPage(),
                              ),
                            );
                            if (data != null) {
                              _controller.text = data[0];
                              returndata = data;
                              setState(() {
                                isDataAviable = true;
                              });
                              LocalRepo.insertRecentSearch(data);
                            }
                          },
                          controller: _controller,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                            prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                height: 10,
                                child: Image.asset(
                                    'assets/images/googlemapsmax.png')),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                    visible: _controller.text.isNotEmpty,
                                    child: IconButton(
                                        onPressed: () {
                                          _controller.text = "";
                                          items.clear();
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.close))),
                                Visibility(
                                    visible: _controller.text.isEmpty,
                                    child: IconButton(
                                        onPressed: () {
                                          _controller.text = "";
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.mic))),
                                Visibility(
                                    visible: _controller.text.isEmpty,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 5),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundImage: AssetImage(
                                          'assets/images/profile.jpg',
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            filled: true,
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
                                color: Colors
                                    .grey, // Adjust the color of the hint text
                                fontWeight: FontWeight
                                    .w400 // You can adjust other properties like fontSize, fontWeight, etc.
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final DateTimeRange? dateTimeRange =
                            await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(today.year, 1, 1),
                                lastDate: DateTime(today.year, 12, 31));
                        if (dateTimeRange != null) {
                          String formatedStartDate = start.year.toString() +
                              "/" +
                              start.month.toString() +
                              "/" +
                              start.day.toString();
                          String formatedEndDate = end.year.toString() +
                              "/" +
                              end.month.toString() +
                              "/" +
                              end.day.toString();
                          var weatherReportRes =
                              await WeatherApi.getWeatherReport(
                                  returndata[2][0],
                                  returndata[2][1],
                                  formatedStartDate,
                                  formatedEndDate);
                          if (weatherReportRes !=
                              "No specific weather condition") {
                            isResultAviable = true;
                            weatherReportResult = weatherReportRes.toString();
                          } else {}
                          setState(() {
                            selectedDates = dateTimeRange;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 120,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.blueGrey)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Departure",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(0, 0, 0, 0.8),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text('${start.day}',
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
                                Text(HelperMethods.getMonthName(start.month),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                      fontSize: 20,
                                    )),
                                Text("'${(start.year) % 100}",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 24))
                              ],
                            ),
                            Text(HelperMethods.getDayName(start.weekday),
                                style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.blueGrey)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Return",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(0, 0, 0, 0.8),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisAlignment: MainAxisAlignment.start,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text("${end.day}",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              Text(HelperMethods.getMonthName(end.month),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    fontSize: 20,
                                  )),
                              Text("'${(end.year) % 100}",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                      fontSize: 24))
                            ],
                          ),
                          Text(HelperMethods.getDayName(end.weekday),
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  fontSize: 16))
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isResultAviable,
                  child: Text(
                    weatherReportResult.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    "Near by Places",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 220,
                  child: FutureBuilder(
                      future: NearbyApi.getNearByPlaces(
                          81.69405170700685, 16.77909917686155),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data!.data[index].name != null) {
                                return Card(
                                  elevation: 4,
                                  child: Container(
                                    width: 170,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image(
                                              image: NetworkImage(snapshot
                                                  .data!
                                                  .data[index]
                                                  .photo!
                                                  .images!
                                                  .medium!
                                                  .url
                                                  .toString()),
                                              alignment: Alignment.center,
                                              height: 150,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            children: [
                                              Text(
                                                snapshot.data!.data[index].name
                                                        .toString() ??
                                                    "text",
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 15,
                                                        child: Image.asset(
                                                            'assets/images/star1.png'),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(snapshot.data!
                                                          .data[index].rating
                                                          .toString()),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Text("error");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Text("");
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nature of Trip",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customRadio("Bussiness", 1),
                          customRadio("Family", 2),
                          customRadio("Company", 3),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Members",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Counter(
                  header: "Men",
                  initialValue: 0,
                  icon: Icon(Icons.person),
                ),
                Divider(
                  height: 20,
                ),
                Counter(
                  header: "Women",
                  initialValue: 0,
                  icon: Icon(Icons.e_mobiledata),
                ),
                Divider(
                  height: 20,
                ),
                Counter(
                  header: "children",
                  initialValue: 0,
                  icon: Icon(Icons.person),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Activities",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TravelActivitySelector(
                  travelActivities: travelActivities,
                  onSelectionChanged: (selectedActivities) {
                    print(selectedActivities);
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
