import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:locationsearch/Apis/WeatherApi.dart';
import 'package:locationsearch/Screens/AiTripPage.dart';
import 'package:locationsearch/Screens/OfflineAiTripPage.dart';
import 'package:toastification/toastification.dart';

class SavedTripsPage extends StatefulWidget {
  const SavedTripsPage({Key? key}) : super(key: key);

  @override
  _SavedTripsPageState createState() => _SavedTripsPageState();
}

class _SavedTripsPageState extends State<SavedTripsPage> {
  // ValueNotifier<bool> _isUpdating = ValueNotifier<bool>(false);
  ValueNotifier<int> _clickedIndex = ValueNotifier<int>(-1);
  Set<int> _clickedIndices = {};
  ValueNotifier<bool> _refreshNotifier = ValueNotifier<bool>(false);

  final user = FirebaseAuth.instance.currentUser;
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String month = '';
    switch (date.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      case 12:
        month = 'Dec';
        break;
    }
    return '$month ${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     icon: const Icon(
            //       Icons.arrow_back,
            //       color: Colors.black,
            //       size: 28,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Saved Trips",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .collection('UserData')
                    .orderBy('Time', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No saved trips',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String documentId = document.id;
                        String location = document['Location'];
                        String weathercondition = document['WeatherCondition'];
                        String activities = document['Activities']
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '');
                        String men = document['Men'].toString();
                        String women = document['Women'].toString();
                        String children = document['Children'].toString();
                        String logitude = document['Logitude'].toString();
                        String latitude = document['Latitude'].toString();
                        String triptype = document['TripType'].toString();
                        String tripplan = document['TripPlan'].toString();

                        DateTime datefrom = document['DateFrom'].toDate();
                        String imgurl = document['ImgUrl'].toString();
                        String formattedatefrom =
                            DateFormat('yyyy-MM-dd').format(datefrom);
                        DateTime dateto = document['DateTo'].toDate();
                        String formattedateto =
                            DateFormat('yyyy-MM-dd').format(dateto);
                        Duration difference = dateto.difference(datefrom);
                        int differenceInDays = difference.inDays;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (tripplan != "") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        OfflineAiTripPage(jsonData: tripplan)));
                              } else {
                                toastification.show(
                                  context: context,
                                  alignment: Alignment.center,
                                  type: ToastificationType.success,
                                  title: const Text('No Trip Plan.'),
                                  autoCloseDuration: const Duration(seconds: 5),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 340,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: const Offset(
                                          0, 3), // Offset in x and y direction
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: imgurl,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/images/placeholder.png',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.black87,
                                                Colors.transparent
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                triptype,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DeletePlanBottomSheet(
                                                        document: document,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.more_horiz,
                                                  color: Colors.white70,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            top: 120,
                                            left: 20,
                                            child: Row(
                                              children: [
                                                Text(
                                                  formatDate(formattedatefrom),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text(
                                                  ' - ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  formatDate(formattedateto),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )),
                                        Positioned(
                                          top: 150,
                                          left: 20,
                                          child: Text(
                                            location,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(location,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            weathercondition,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 0,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    activities,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // ElevatedButton(
                                            //   onPressed: () async {
                                            //     _clickedIndex.value = index;
                                            //     var weatherReportRes =
                                            //         await WeatherApi
                                            //             .getWeatherReport(
                                            //                 double.parse(
                                            //                     logitude),
                                            //                 double.parse(
                                            //                     latitude),
                                            //                 formattedatefrom,
                                            //                 formattedateto);
                                            //     print(weatherReportRes);

                                            //     updateDocument(documentId,
                                            //         user!.uid, weatherReportRes);
                                            //     _clickedIndex.value = -1;
                                            //   },
                                            //   child: ValueListenableBuilder<int>(
                                            //     valueListenable: _clickedIndex,
                                            //     builder: (context, value, child) {
                                            //       return Text(
                                            //         value == index
                                            //             ? "Updating..."
                                            //             : "Refresh",
                                            //       );
                                            //     },
                                            //   ),
                                            // )
                                            ElevatedButton(
                                              onPressed: _clickedIndices
                                                      .contains(index)
                                                  ? null // Disable button if already clicked
                                                  : () async {
                                                      // Add index to set
                                                      _clickedIndices
                                                          .add(index);
                                                      _refreshNotifier.value =
                                                          !_refreshNotifier
                                                              .value; // Trigger rebuild
                                                      var weatherReportRes =
                                                          await WeatherApi
                                                              .getWeatherReport(
                                                                  double.parse(
                                                                      logitude),
                                                                  double.parse(
                                                                      latitude),
                                                                  formattedatefrom,
                                                                  formattedateto);
                                                      print(weatherReportRes);
                                                      // Update document
                                                      updateDocument(
                                                          documentId,
                                                          user!.uid,
                                                          weatherReportRes);
                                                      // Remove index from set after update
                                                      _clickedIndices
                                                          .remove(index);
                                                      _refreshNotifier.value =
                                                          !_refreshNotifier
                                                              .value;
                                                    },
                                              child:
                                                  ValueListenableBuilder<bool>(
                                                valueListenable:
                                                    _refreshNotifier,
                                                builder:
                                                    (context, value, child) {
                                                  return Text(
                                                    _clickedIndices
                                                            .contains(index)
                                                        ? "Updating..."
                                                        : "Refresh",
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateDocument(documentId, userid, weatherCondition) async {
    // Reference to the document you want to update
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('UserData')
        .doc(documentId);

    try {
      await documentRef.update({
        'WeatherCondition': weatherCondition,
      });
      print('Document updated successfully.');
    } catch (e) {
      print('Error updating document: $e');
    }
  }
}

class DeletePlanBottomSheet extends StatelessWidget {
  final DocumentSnapshot? document;
  const DeletePlanBottomSheet({Key? key, this.document})
      : super(key: key); // Constructor to accept the DocumentSnapshot

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              document!.reference.delete();
              Navigator.pop(context); // Close the bottom sheet
            },
            child: const Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Delete Plan',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
