import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:locationsearch/Models/AiResponseModel.dart';
import 'package:lottie/lottie.dart';

import 'PlacePage.dart';

class OfflineAiTripPage extends StatefulWidget {
  final String jsonData;

  OfflineAiTripPage({
    Key? key,
    required this.jsonData,
  }) : super(key: key);

  @override
  State<OfflineAiTripPage> createState() => _OfflineAiTripPageState();
}

class _OfflineAiTripPageState extends State<OfflineAiTripPage> {
  final user = FirebaseAuth.instance.currentUser;
  AiResponseModel? trip;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    String jsonString = widget.jsonData;

    // Convert string to map
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert map to YourModel instance
    trip = AiResponseModel.fromJson(jsonMap);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  )),
            ),
            isLoading
                ? Center(
                    child: Lottie.asset('assets/images/loading3.json',
                        fit: BoxFit.fill),
                  )
                : trip == null
                    ? const Center(
                        child: Text(
                            'No data available'), // Show message if no data available
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Your existing UI elements to display trip data
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: trip!.itinerary.map((day) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Day ${day.day} - ${day.date}',
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              day.placesToVisit.map((place) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${place.name}',
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Best Time to Visit: ${place.bestTimeToVisit}',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black54),
                                                ),
                                                RatingBarIndicator(
                                                  rating: double.parse(
                                                      place.rating.toString()),
                                                  itemSize: 22,
                                                  direction: Axis.horizontal,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${place.description}',
                                                ),

                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      MapUtils.openMap(
                                                          double.parse(place
                                                              .latitude
                                                              .toString()),
                                                          double.parse(place
                                                              .longitude
                                                              .toString()));
                                                    },
                                                    child: Container(
                                                      width: 140,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.map,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "View map",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                // Text('Latitude: ${place.latitude}'),
                                                // Text('Longitude: ${place.longitude}'),
                                                const Divider(),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const Text(
                                  'Budget Estimate:',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("Accommodation Range per Night",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  '${trip!.budgetEstimate!.accommodation!.rangePerNight}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Meals Range per Person",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  '${trip!.budgetEstimate!.mealsPerDayPerPerson!.range}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                const Text("Transportation Range",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.transportation!.rangeFor5Days}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Attractions Range",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.attractions!.rangeFor5DaysPerPerson}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Miscellaneous Range",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.miscellaneous!.rangeFor5Days}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Total Estimated Budget",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.totalEstimatedBudgetPerPerson!.range}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
