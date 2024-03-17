import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:locationsearch/Apis/NearbyApi.dart';
import 'package:locationsearch/Apis/WeatherApi.dart';
import 'package:locationsearch/Controllers/DataController.dart';
import 'package:locationsearch/DB/LocalRepo.dart';
import 'package:locationsearch/Helpers/HelperMethods.dart';
import 'package:locationsearch/Models/LocationDataModel.dart' as locationdata;
import 'package:locationsearch/Models/NearByModel.dart';
import 'package:locationsearch/Screens/PlacePage.dart';
import 'package:locationsearch/Screens/SearchPage.dart';
import 'package:locationsearch/Screens/SettingsPage.dart';
import 'package:locationsearch/widgets/CounterWidgets.dart';
import 'package:locationsearch/widgets/CustomRadio.dart';
import 'package:locationsearch/widgets/TravelActivitySelector.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataController dataController = Get.put(DataController());
  DataController dataControllerVariable = Get.find<DataController>();
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  final user = FirebaseAuth.instance.currentUser;
  List<locationdata.LocationDataModel> items = [];
  dynamic returndata;
  bool isDataAviable = false;
  bool isResultAviable = false;
  String? weatherReportResult;
  bool isNearbyDataAvaliable = false;
  double? lon;
  double? lat;
  final DateTime today = DateTime.now();
  int _selectedTrip = 0;
  Future<NearbyModel>? _nearby;
  List<String> selectedActivitie = [];
  //var _currentWeather = 0.obs;
  var currentWeather = 0.obs;
  var count = 0.obs;

  String men = "0";
  String women = "0";
  String childern = "0";
  bool isIntial = true;

  final List<String> travelActivities = [
    'Sightseeing',
    'Hiking and Trekking',
    'Cultural Tours',
    'Swing',
    'Cool'
  ];

  int _counterValue1 = 0;
  int _counterValue2 = 0;
  int _counterValue3 = 0;
  void _isDataAviable() {
    setState(() => isDataAviable = true);
  }

  void fetchdataloc(dateTimeRange) {
    setState(() {
      lon = returndata[2][0];
      lat = returndata[2][1];
      isIntial = false;
      fetchData(isIntial);
      selectedDates = dateTimeRange;
    });
  }

  void simpleSetState() {
    setState(() {});
  }

  void _selectedActivity(selectedActivities) {
    setState(() {
      selectedActivitie = selectedActivities;
    });
  }

  void _handleCounter1ValueChanged(int value) {
    setState(() {
      _counterValue1 = value;
    });
  }

  void _handleCounter2ValueChanged(int value) {
    setState(() {
      _counterValue2 = value;
    });
  }

  void _handleCounter3ValueChanged(int value) {
    setState(() {
      _counterValue3 = value;
    });
  }

  void _handleTap(int index) {
    // Handle the logic without using setState
    // For example, you can update the selectedTrip directly here
    // selectedTrip = index;
    _selectedTrip = index;
    setState(() {});
    // Do something else...
  }

  TextEditingController _controller = TextEditingController();
  DateTimeRange selectedDates = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 2)));

  @override
  void initState() {
    // _initializeData();
    super.initState();
    dataController.getLocation();
  }

  // Future<void> _getLocation() async {
  //   final permissionStatus = await location.hasPermission();
  //   if (permissionStatus == PermissionStatus.granted) {
  //     _getLocationData();
  //   } else {
  //     _fetchWeatherByIP();
  //   }
  // }

  Future addDetails(location, datefrom, dateto, triptype, men, women, children,
      activities) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('UserData')
          .add({
        'Location': location,
        'DateFrom': datefrom,
        'DateTo': dateto,
        'TripType': triptype,
        'Men': men,
        'Women': women,
        'Children': children,
        'Activities': activities
      });
      toastification.show(
        context: context,
        alignment: Alignment.center,
        type: ToastificationType.success,
        title: const Text('Trip Deatils Saved'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } on FirebaseException catch (e) {
      toastification.show(
        context: context,
        alignment: Alignment.center,
        type: ToastificationType.error,
        title: Text(e.message.toString()),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  Future<NearbyModel>? fetchData(isIntial) async {
    setState(() {});
    // return await NearbyApi.getNearByPlaces(lon!, lat!);
    if (!isIntial) {
      return await NearbyApi.getNearByPlaces(
          dataControllerVariable.longitude.value,
          dataControllerVariable.latitude.value);
    } else {
      if (dataControllerVariable.longitude.value != 0.0) {
        return await NearbyApi.getNearByPlaces(
            dataControllerVariable.longitude.value,
            dataControllerVariable.latitude.value);
      } else {
        return await NearbyApi.getNearByPlaces(lon!, lat!);
      }
    }
  }

  @override
  void dispose() {
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  // user!.email ?? "Guest",

                                  user!.displayName != null &&
                                          user!.displayName != ""
                                      ? user!.displayName!
                                      : user!.email!,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => Visibility(
                                visible: dataController.isVisible.value,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 30,
                                        child: Image.asset(
                                            "assets/images/cloudy.png")),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() => Text(
                                        "${dataController.currentWeather}°C",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400)))
                                  ],
                                ),
                              )),
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
                                _isDataAviable();
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
                                            simpleSetState();
                                          },
                                          icon: const Icon(Icons.close))),
                                  Visibility(
                                      visible: _controller.text.isEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SettingsPage()));
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundImage:
                                                // AssetImage(
                                                //     'assets/images/profile.jpg')
                                                user!.photoURL != null &&
                                                        user!.photoURL != ""
                                                    ? NetworkImage(
                                                        user!.photoURL!)
                                                    : const AssetImage(
                                                            'assets/images/profile.jpg')
                                                        as ImageProvider,
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(today.year, 12, 31));
                          if (dateTimeRange != null) {
                            String formatedStartDate =
                                "${start.year}/${start.month}/${start.day}";
                            String formatedEndDate =
                                "${end.year}/${end.month}/${end.day}";
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
                            fetchdataloc(dateTimeRange);
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
                            border:
                                Border.all(width: 1, color: Colors.blueGrey)),
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
                        future: fetchData(isIntial),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data!.data[index].name != null &&
                                    snapshot.data!.data[index].photo != null &&
                                    snapshot.data!.data[index].rating != null) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => PlacePage(
                                          // placeLocationModel: snapshot
                                          //     .data!.data[index],
                                          name: snapshot.data!.data[index].name,
                                          image: snapshot.data!.data[index]
                                              .photo.images.original.url,
                                          address: snapshot
                                              .data!.data[index].address,

                                          latitude: snapshot
                                              .data!.data[index].latitude,
                                          longitude: snapshot
                                              .data!.data[index].longitude,
                                          rating:
                                              snapshot.data!.data[index].rating,
                                          description: snapshot
                                              .data!.data[index].description,
                                        ),
                                      ));
                                    },
                                    child: Card(
                                      elevation: 4,
                                      child: SizedBox(
                                        width: 170,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      snapshot.data!.data[index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 15,
                                                        child: Image.asset(
                                                            'assets/images/star1.png'),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(snapshot.data!
                                                          .data[index].rating
                                                          .toString()),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Text("");
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const Text("rrr");
                          }
                        },
                      )),
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
                            CustomRadio(
                              text: 'Business',
                              index: 1, // or any index you want
                              selectedTrip: _selectedTrip,
                              onTap: _handleTap,
                            ),
                            CustomRadio(
                              text: 'Family',
                              index: 2, // or any index you want
                              selectedTrip: _selectedTrip,
                              onTap: _handleTap,
                            ),
                            CustomRadio(
                              text: 'Company',
                              index: 3, // or any index you want
                              selectedTrip: _selectedTrip,
                              onTap: _handleTap,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
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
                    header: 'Men',
                    initialValue: _counterValue1,
                    onValueChanged: _handleCounter1ValueChanged,
                    icon:
                        const Icon(Icons.person), // You can pass the icon here
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Counter(
                    header: 'Women',
                    initialValue: _counterValue2,
                    onValueChanged: _handleCounter2ValueChanged,
                    icon:
                        const Icon(Icons.person), // You can pass the icon here
                  ),
                  const Divider(
                    height: 20,
                  ),
                  Counter(
                    header: 'Children',
                    initialValue: _counterValue3,
                    onValueChanged: _handleCounter3ValueChanged,
                    icon:
                        const Icon(Icons.person), // You can pass the icon here
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
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
                      _selectedActivity(selectedActivities);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: isResultAviable,
            child: FloatingActionButton(
              // isExtended: true,
              child: const Icon(Icons.save),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                String triptype = "";
                if (_selectedTrip == 1) {
                  triptype = 'Business';
                } else if (_selectedTrip == 2) {
                  triptype = 'Family';
                } else {
                  triptype = 'Company';
                }
                addDetails(
                    _controller.text.trim(),
                    start,
                    end,
                    triptype,
                    _counterValue1,
                    _counterValue2,
                    _counterValue3,
                    selectedActivitie);
              },
            ),
          )),
    );
  }
}
