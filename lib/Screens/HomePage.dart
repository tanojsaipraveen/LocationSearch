import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:locationsearch/Apis/LocationCoordinate.dart';
import 'package:locationsearch/Apis/NearbyApi.dart';
import 'package:locationsearch/Apis/WeatherApi.dart';
import 'package:locationsearch/Constants/weatherConditionlist.dart';
import 'package:locationsearch/Controllers/DataController.dart';
import 'package:locationsearch/DB/LocalRepo.dart';
import 'package:locationsearch/Helpers/HelperMethods.dart';
import 'package:locationsearch/Models/LocationDataModel.dart' as locationdata;
import 'package:locationsearch/Models/NearByModel.dart';
import 'package:locationsearch/Models/WeatherResultModel.dart';
import 'package:locationsearch/Screens/AiTripPage.dart';
import 'package:locationsearch/Screens/PlacePage.dart';
import 'package:locationsearch/Screens/SearchPage.dart';
import 'package:locationsearch/Screens/SettingsPage.dart';
import 'package:locationsearch/widgets/CounterWidgets.dart';
import 'package:locationsearch/widgets/CustomRadio.dart';
import 'package:locationsearch/widgets/TravelActivitySelector.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> weatherData = jsonDecode(weatherConditions());
  List<String> essentials = [];
  final chatGpt = ChatGpt(apiKey: dotenv.env["ChatGPTAPI"].toString());
  final testPrompt =
      'Which Disney character famously leaves a glass slipper behind at a royal ball?';

  final testRequest = ChatCompletionRequest(
    stream: true,
    maxTokens: 16,
    messages: [
      Message(
          role: Role.user.name,
          content:
              'Which Disney character famously leaves a glass slipper behind at a royal ball?')
    ],
    model: ChatGptModel.gpt35Turbo.modelName,
  );

  late TextEditingController textEditingController;

  StreamSubscription<CompletionResponse>? streamSubscription;

  final double headersFontSize = 18.0;
  ValueNotifier<bool> isTaskRunningNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);
  DataController dataController = Get.put(DataController());
  DataController dataControllerVariable = Get.find<DataController>();
  // Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  final user = FirebaseAuth.instance.currentUser;
  List<locationdata.LocationDataModel> items = [];
  dynamic returndata;
  bool isDataAviable = false;
  bool isResultAviable = false;
  ValueNotifier<bool> _isResultLoading = ValueNotifier<bool>(false);
  String? weatherReportResult;
  String? weatherReportResultCondition;
  bool isNearbyDataAvaliable = false;
  double? lon;
  double? lat;
  final DateTime today = DateTime.now();
  int _selectedTrip = 0;
  Future<NearbyModel>? _nearby;
  Future<WeatherResultModel>? _fetchDayWeather;
  List<String> selectedActivitie = [];
  //var _currentWeather = 0.obs;
  var currentWeather = 0.obs;
  var count = 0.obs;

  String formattedStartDate = "";
  String formattedEndDate = "";

  final ValueNotifier<String> imgforsavedtrips = ValueNotifier<String>('');

  String men = "0";
  String women = "0";
  String childern = "0";
  bool isIntial = true;

  final List<String> travelActivities = [
    "Sightseeing",
    "Hiking",
    "Photography",
    "Beach activities",
    "Cultural experiences",
    "Food tours",
    "Adventure sports",
    "Wildlife viewing",
    "Cycling",
    "Boat tours",
    "Shopping",
    "Spa and wellness",
    "Volunteer activities",
    "Wine tasting",
    "Cooking classes",
    "Historical reenactments",
    "Eco-tourism",
    "Cultural performances",
    "Hot air balloon rides",
    "Stargazing"
  ];

  final iconswithnumber = {
    23: "HeavyDrizzle",
    40: "HeavyDrizzle",
    26: "SnowShowersDayV2",
    6: "BlowingHailV2",
    5: "CloudyV3",
    20: "LightSnowV2",
    91: "WindyV2",
    27: "ThunderstormsV2",
    10: "FreezingRainV2",
    77: "RainSnowV2",
    12: "Haze",
    13: "HeavyDrizzle",
    39: "Fair",
    24: "RainSnowV2",
    78: "RainSnowShowersNightV2",
    9: "FogV2",
    3: "PartlyCloudyDayV3",
    43: "IcePelletsV2",
    16: "IcePellets",
    8: "LightRainV2",
    15: "HeavySnowV2",
    28: "ClearNightV3",
    30: "PartlyCloudyNightV2",
    14: "ModerateRainV2",
    1: "SunnyDayV3",
    7: "BlowingSnowV2",
    50: "RainShowersNightV2",
    82: "LightSnowShowersNight",
    81: "LightSnowShowersDay",
    2: "MostlySunnyDay",
    29: "MostlyClearNight",
    4: "MostlyCloudyDayV2",
    31: "MostlyCloudyNightV2",
    19: "LightRainV3",
    17: "LightRainShowerDay",
    53: "N422Snow",
    52: "Snow",
    25: "Snow",
    44: "LightRainShowerNight",
    65: "HailDayV2",
    73: "HailDayV2",
    74: "HailNightV2",
    79: "RainShowersDayV2",
    89: "HazySmokeV2",
    90: "HazeSmokeNightV2_106",
    66: "HailNightV2",
    59: "WindyV2",
    56: "ThunderstormsV2",
    58: "FogV2",
    54: "HazySmokeV2",
    55: "Dust1",
    57: "Haze"
  };

  int _counterValue1 = 0;
  int _counterValue2 = 0;
  int _counterValue3 = 0;
  void _isDataAviable() {
    setState(() => isDataAviable = true);
  }

  void fetchdataloc(dateTimeRange) {
    _isLoading.value = true;
    setState(() {
      lon = returndata[2][0];
      lat = returndata[2][1];
      isIntial = false;

      _nearby = fetchData(isIntial, lon, lat);
      _isLoading.value = false;
      selectedDates = dateTimeRange;
    });
  }

  void fetchdayweather() {
    setState(() {
      _fetchDayWeather = _fetchWeatherRes(returndata[2][0], returndata[2][1],
          formattedStartDate, formattedEndDate);
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

  Future<WeatherResultModel> _fetchWeatherRes(
      double lon, double lat, String start, String end) {
    return WeatherApi.getWeatherReportResult(lon, lat, start, end);
  }

  void saveTextToFile(String text) async {
    final downloadsDirectory = await getDownloadsDirectory();
    final file = File('${downloadsDirectory!.path}/my_file.txt');

    await file.writeAsString(text);
  }

  Future<bool> fetchStatus() async {
    // Reference to your Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('status');

    // Get the document snapshot
    DocumentSnapshot snapshot = await users.doc('disable').get();
    bool isDisabled = false;
    // Check if the document exists and contains the "isdisable" field
    if (snapshot.exists &&
        snapshot.data() is Map<String, dynamic> &&
        (snapshot.data() as Map<String, dynamic>).containsKey('isdisable')) {
      // Access the value of the "isdisable" field
      isDisabled = (snapshot.data() as Map<String, dynamic>)['isdisable'];
      print('isdisable value: $isDisabled');
      return isDisabled;
    } else {
      print(
          'Document does not exist or does not contain the "isdisable" field.');
      return isDisabled;
    }
  }

  void _handleTap(int index) {
    _selectedTrip = index;
    setState(() {});
  }

  TextEditingController _controller = TextEditingController();
  DateTimeRange selectedDates = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 2)));

  @override
  void initState() {
    super.initState();

    getlocationdetails();
  }

  Future<void> getlocationdetails() async {
    LoactionCoordinate loactionCoordinate = LoactionCoordinate();
    var locationres = await loactionCoordinate.fetchLocationData();
    //   _nearby = fetchData(isIntial, locationres[0], locationres[1]);
    if (_nearby != null) {
      _isLoading.value = false;
    }

    await dataController.getLocation();
    _nearby = fetchData(isIntial, locationres[0], locationres[1]);
    _isLoading.value = false;
  }

  Future<String?> addDetails(
      location,
      datefrom,
      dateto,
      triptype,
      men,
      women,
      children,
      activities,
      weatherReportResultCondition,
      imgforsavedtrips,
      lon,
      lat) async {
    String result = "";
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
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
        'Activities': activities,
        'WeatherCondition': weatherReportResultCondition,
        'Time': Timestamp.fromDate(DateTime.now()),
        'ImgUrl': imgforsavedtrips.value,
        'Logitude': lon,
        'Latitude': lat,
        'TripPlan': ""
      });

      setState(() {
        isTaskRunningNotifier.value = false;
      });

      toastification.show(
        context: context,
        alignment: Alignment.center,
        type: ToastificationType.success,
        title: const Text('Trip Deatils Saved'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      return docRef.id;
    } on FirebaseException catch (e) {
      toastification.show(
        context: context,
        alignment: Alignment.center,
        type: ToastificationType.error,
        title: Text(e.message.toString()),
        autoCloseDuration: const Duration(seconds: 5),
      );
      return result;
    }
  }

  Future<NearbyModel> fetchData(isIntial, lon1, lat1) async {
    if (!isIntial) {
      return await NearbyApi.getNearByPlaces(
        returndata[2][0],
        returndata[2][1],
      );
    } else {
      return await NearbyApi.getNearByPlaces(
          double.parse(lon1!), double.parse(lat1!));
      //}
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("main build");
    final start = selectedDates.start;
    final end = selectedDates.end;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(131, 216, 226, 1),
                      Color.fromRGBO(165, 230, 206, 1)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SettingsPage()));
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                // AssetImage(
                                //     'assets/images/profile.jpg')
                                user!.photoURL != null && user!.photoURL != ""
                                    ? NetworkImage(user!.photoURL!)
                                    : const AssetImage(
                                            'assets/images/profile.jpg')
                                        as ImageProvider,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
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
                                      fontSize: 16, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() => Visibility(
                              visible: dataController.isVisible.value,
                              //visible: true,
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
                            var result = await fetchStatus();
                            if (!result) {
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
                            } else {}
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
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      essentials.clear();
                      SystemChrome.setSystemUIOverlayStyle(
                          SystemUiOverlayStyle.dark);
                      final DateTimeRange? dateTimeRange =
                          await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(today.year, 12, 31),
                      );

                      if (dateTimeRange != null) {
                        _isResultLoading.value = true;
                        setState(() {
                          formattedStartDate = DateFormat('yyyy/MM/dd')
                              .format(dateTimeRange.start);
                          formattedEndDate = DateFormat('yyyy/MM/dd')
                              .format(dateTimeRange.end);
                        });

                        var weatherReportRes =
                            await WeatherApi.getWeatherReport(
                          returndata[2][0],
                          returndata[2][1],
                          formattedStartDate,
                          formattedEndDate,
                        );

                        final List<String> currentWeather = [
                          "Rainy",
                          "Snowy",
                          "Sunny",
                          "Mostly Cloudy"
                        ];

                        weatherReportResultCondition = weatherReportRes;

                        currentWeather.forEach((weather) {
                          if (weatherReportRes.toString().contains(weather)) {
                            if (weatherData.containsKey(weather)) {
                              Map<String, dynamic> weatherDetails =
                                  weatherData[weather];
                              essentials.addAll(List<String>.from(
                                  weatherDetails['Essentials']));
                            }
                          }
                        });

                        if (weatherReportRes !=
                            "No specific weather condition") {
                          isResultAviable = true;
                          _isResultLoading.value = false;
                          weatherReportResult = essentials.join('\n');
                        }
                        fetchdayweather();
                        fetchdataloc(dateTimeRange);
                      }
                    },
                    child: Container(
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
                            "Departure",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(101, 101, 101, 0.8),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))
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
                            color: Color.fromRGBO(101, 101, 101, 0.8),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isResultAviable && _controller.text.isNotEmpty,
                //visible: true,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Essentials for $weatherReportResultCondition',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Column(
                        children: [
                          for (int i = 0; i < essentials.length; i += 2)
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        essentials[i],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )),
                                if (i + 1 < essentials.length)
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 12,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          essentials[i + 1],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  )),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _isResultLoading,
                  builder: (context, isLoading, child) {
                    return Visibility(
                        visible: isLoading,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                  }),
              isResultAviable
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 100,
                      child: FutureBuilder<WeatherResultModel>(
                        future: _fetchDayWeather,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            final weatherResult = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.value[0].responses[0]
                                  .weather[0].days.length,
                              itemBuilder: (BuildContext context, int index) {
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
                                              'https://assets.msn.com/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/${iconswithnumber[snapshot.data!.value[0].responses[0].weather[0].days[index].daily!.icon]}.svg',
                                              semanticsLabel: 'Weather Icon',
                                              placeholderBuilder: (BuildContext
                                                      context) =>
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          convertTimeFormat(snapshot
                                              .data!
                                              .value[0]
                                              .responses[0]
                                              .weather[0]
                                              .days[index]
                                              .daily!
                                              .valid
                                              .toString()),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: Text(
                                            snapshot
                                                .data!
                                                .value[0]
                                                .responses[0]
                                                .weather[0]
                                                .days[index]
                                                .daily!
                                                .tempHi
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Text(
                                            snapshot
                                                .data!
                                                .value[0]
                                                .responses[0]
                                                .weather[0]
                                                .days[index]
                                                .daily!
                                                .tempLo
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text('No data available'),
                            );
                          }
                        },
                      ),
                    )
                  : Text(""),
              const SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Container(
              //     height: 120,
              //     child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: travelActivities.length,
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 5),
              //             child: Stack(
              //               children: [
              //                 Container(
              //                   width: 100,
              //                   height: 120,
              //                   decoration: BoxDecoration(
              //                     color: Colors.amber,
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   child: Stack(
              //                     alignment: Alignment
              //                         .center, // Align image to the left side
              //                     children: [
              //                       SizedBox(
              //                         width: 100,
              //                         height: 120,
              //                         child: ClipRRect(
              //                           borderRadius: BorderRadius.circular(10),
              //                           child: Image.asset(
              //                             'assets/images/hiking.jpg',
              //                             fit: BoxFit
              //                                 .cover, // Adjusted fit to fit height
              //                             // Set the height of the image to match the container
              //                           ),
              //                         ),
              //                       ),
              //                       Container(
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(10),
              //                           gradient: LinearGradient(
              //                             begin: Alignment.bottomCenter,
              //                             end: Alignment.topCenter,
              //                             colors: [
              //                               Colors.black.withOpacity(
              //                                   0.6), // Adjust opacity or change color as needed
              //                               Colors
              //                                   .transparent, // You can add more colors here if desired
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 Positioned(
              //                   top: 10,
              //                   left: 10,
              //                   child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(10),
              //                     child: Stack(
              //                       alignment: Alignment.center,
              //                       children: [
              //                         Container(
              //                           height: 13,
              //                           width: 13,
              //                           decoration: BoxDecoration(
              //                             color: Colors.white,
              //                             borderRadius:
              //                                 BorderRadius.circular(100),
              //                           ),
              //                         ),
              //                         Container(
              //                           height: 10,
              //                           width: 10,
              //                           decoration: BoxDecoration(
              //                             color: Theme.of(context).primaryColor,
              //                             borderRadius:
              //                                 BorderRadius.circular(100),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   bottom: 10,
              //                   left: 10,
              //                   child: Text(
              //                     travelActivities[index],
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.w700,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           );
              //         }),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Nearby Destinations",
                        style: TextStyle(
                            fontSize: headersFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 220,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isLoading,
                        builder: (context, isLoading, child) {
                          if (isLoading) {
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  5, // Set a fixed number of shimmer items
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      Colors.grey[300]!, // Shimmer base color
                                  highlightColor: Colors
                                      .grey[100]!, // Shimmer highlight color
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return FutureBuilder(
                              future: _nearby!,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (snapshot.data!.data[index].name !=
                                              null &&
                                          snapshot.data!.data[index].photo !=
                                              null &&
                                          snapshot.data!.data[index].rating !=
                                              null) {
                                        imgforsavedtrips.value = snapshot.data!
                                            .data[0].photo.images.original.url;

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => PlacePage(
                                                // placeLocationModel: snapshot
                                                //     .data!.data[index],
                                                name: snapshot
                                                    .data!.data[index].name,
                                                image: snapshot
                                                    .data!
                                                    .data[index]
                                                    .photo
                                                    .images
                                                    .original
                                                    .url,
                                                address: snapshot
                                                    .data!.data[index].address,

                                                latitude: snapshot
                                                    .data!.data[index].latitude,
                                                longitude: snapshot.data!
                                                    .data[index].longitude,
                                                rating: snapshot
                                                    .data!.data[index].rating,
                                                description: snapshot.data!
                                                    .data[index].description,
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
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: snapshot
                                                              .data!
                                                              .data[index]
                                                              .photo!
                                                              .images!
                                                              .medium!
                                                              .url
                                                              .toString(),
                                                          height: 150,
                                                          width: 200,
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Image.asset(
                                                            'assets/images/placeholder.png',
                                                            height: 150,
                                                            width: 200,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .data[index]
                                                                .name
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 15,
                                                              child: Image.asset(
                                                                  'assets/images/star1.png'),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Text(snapshot
                                                                .data!
                                                                .data[index]
                                                                .rating
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
                                  return const Text("Error");
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return const Text("rrr");
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isResultAviable && _controller.text.isNotEmpty,
                      //visible: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nature of Trip",
                              style: TextStyle(
                                  fontSize: headersFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isResultAviable && _controller.text.isNotEmpty,
                      //visible: true,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Members",
                              style: TextStyle(
                                  fontSize: headersFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Counter(
                            header: 'Men',
                            initialValue: _counterValue1,
                            onValueChanged: _handleCounter1ValueChanged,
                            iconData:
                                Icons.person, // You can pass the icon here
                          ),
                          const Divider(
                            height: 20,
                          ),
                          Counter(
                            header: 'Women',
                            initialValue: _counterValue2,
                            onValueChanged: _handleCounter2ValueChanged,
                            iconData:
                                Icons.person_2, // You can pass the icon here
                          ),
                          const Divider(
                            height: 20,
                          ),
                          Counter(
                            header: 'Children',
                            initialValue: _counterValue3,
                            onValueChanged: _handleCounter3ValueChanged,
                            iconData:
                                Icons.child_care, // You can pass the icon here
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isResultAviable && _controller.text.isNotEmpty,
                      //visible: true,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Things To Do",
                              style: TextStyle(
                                  fontSize: headersFontSize,
                                  fontWeight: FontWeight.bold),
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: isResultAviable && _controller.text.isNotEmpty,
          child: ValueListenableBuilder<bool>(
            valueListenable: isTaskRunningNotifier,
            builder: (context, isTaskRunning, child) {
              return FloatingActionButton(
                // isExtended: true,
                child: isTaskRunning
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: isTaskRunning
                    ? null
                    : () async {
                        // Update the isTaskRunningNotifier value when the button is pressed
                        isTaskRunningNotifier.value = true;
                        String triptype = "";
                        if (_selectedTrip == 1) {
                          triptype = 'Business';
                        } else if (_selectedTrip == 2) {
                          triptype = 'Family';
                        } else {
                          triptype = 'Company';
                        }

                        var rr = await addDetails(
                            _controller.text.trim(),
                            start,
                            end,
                            triptype,
                            _counterValue1,
                            _counterValue2,
                            _counterValue3,
                            selectedActivitie,
                            weatherReportResultCondition,
                            imgforsavedtrips,
                            lon,
                            lat);
                        isTaskRunningNotifier.value = false;
                        String formattedDate =
                            DateFormat("dd MMMM").format(start);
                        Duration difference = end.difference(start);

                        // Convert the difference to days
                        int daysDifference = difference.inDays;
                        print(formattedDate);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AiTripPage(
                            place: _controller.text.trim(),
                            days: daysDifference.toString(),
                            startDate: formattedDate,
                            docid: rr ?? "",
                          ),
                        ));
                      },
              );
            },
          ),
        ));
  }

  String convertTimeFormat(String originalTime) {
    DateTime dateTime = DateTime.parse(originalTime);
    int day = dateTime.day;
    int month = dateTime.month;
    String formattedDay = day.toString();
    String formattedMonth = month.toString();
    if (formattedDay.startsWith('0')) {
      formattedDay = formattedDay.substring(1);
    }
    if (formattedMonth.startsWith('0')) {
      formattedMonth = formattedMonth.substring(1);
    }
    String formattedTime = '$formattedDay/$formattedMonth';
    return formattedTime;
  }
}
