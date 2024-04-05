import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:locationsearch/Constants/Prompt.dart';
import 'package:locationsearch/Models/AiResponseModel.dart';
import 'package:locationsearch/Screens/PlacePage.dart';
import 'package:lottie/lottie.dart';

class AiTripPage extends StatefulWidget {
  final String place;
  final String days;
  final String startDate;
  final String docid;

  AiTripPage(
      {Key? key,
      required this.place,
      required this.days,
      required this.startDate,
      required this.docid})
      : super(key: key);

  @override
  State<AiTripPage> createState() => _AiTripPageState();
}

class _AiTripPageState extends State<AiTripPage> {
  final user = FirebaseAuth.instance.currentUser;
  AiResponseModel? trip;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch data when the page loads
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true; // Show circular progress indicator
    });

    try {
      // Call your AI service to fetch data

      String res1 =
          await geminiResponse(widget.place, widget.days, widget.startDate);

      Map<String, dynamic> json = jsonDecode(res1);
      AiResponseModel response = AiResponseModel.fromJson(json);
      AILogs(res1);
      updateDocument(widget.docid, user!.uid, res1);
      setState(() {
        // Update the trip model with the fetched data
        trip = response;
        isLoading = false; // Hide circular progress indicator
      });
    } catch (e) {
      print("Error fetching data: $e");
      // Handle error appropriately, e.g., show an error message
      setState(() {
        isLoading = false; // Hide circular progress indicator on error
      });
    }
  }

  void updateDocument(documentId, userid, tripplan) async {
    // Reference to the document you want to update
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('UserData')
        .doc(documentId);

    try {
      await documentRef.update({
        'TripPlan': tripplan,
      });
      print('Document updated successfully.');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  void AILogs(String res) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('log').add({'data': res});
  }

  Future<String> geminiResponse(
      String place, String days, String startDate) async {
    final generationConfig1 = GenerationConfig(
      temperature: 0.9,
      topP: 1.0,
      topK: 1,
    );

    final model = GenerativeModel(
        generationConfig: generationConfig1,
        model: 'gemini-1.0-pro-latest',
        apiKey: dotenv.env["GaminiAPI"].toString());
    final prompt = getprompt(place, days, startDate);

    // final tokenCount = await model.countTokens([Content.text(prompt)]);
    // print('Token count: ${tokenCount.totalTokens}');
    // final content = [Content.text(prompt)];
    // final response = await model.generateContent(content);
    // Map<String, dynamic> json = jsonDecode(response.text.toString());
    // var result = AiResponseModel.fromJson(json);
    // return response.text.toString();

    return await yourFunctionNameWithRetry(prompt, model);
    // try {
    //   final tokenCount = await model.countTokens([Content.text(prompt)]);
    //   print('Token count: ${tokenCount.totalTokens}');
    //   final content = [Content.text(prompt)];
    //   final response = await model.generateContent(content);
    //   Map<String, dynamic> json = jsonDecode(response.text.toString());
    //   var result = AiResponseModel.fromJson(json);
    //   return response.text.toString();
    // } catch (e) {
    //   print('An error occurred: $e');
    //   // Handle the error here, you can return a default value or rethrow the exception
    //   return ''; // or throw e; or any other appropriate handling
    // }
  }

  Future<String> yourFunctionNameWithRetry(String prompt, dynamic model) async {
    int maxRetries = 3;
    int retryCount = 0;
    String result = '';

    while (retryCount < maxRetries) {
      try {
        final tokenCount = await model.countTokens([Content.text(prompt)]);
        print('Token count: ${tokenCount.totalTokens}');
        final content = [Content.text(prompt)];
        final response = await model.generateContent(content);
        Map<String, dynamic> json = jsonDecode(response.text.toString());
        var resultModel = AiResponseModel.fromJson(json);
        result = response.text.toString();
        break; // If execution reached here, no exception occurred, break out of the loop
      } catch (e) {
        print('An error occurred: $e');
        retryCount++;
        if (retryCount == maxRetries) {
          print('Max retry attempts reached.');
          // Handle the error here, you can return a default value or rethrow the exception
          result = ''; // or throw e; or any other appropriate handling
        } else {
          print('Retrying...');
        }
      }
    }

    return result;
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
                    ? Center(
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
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
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
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Best Time to Visit: ${place.bestTimeToVisit}',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black54),
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 15,
                                                      child: Image.asset(
                                                          'assets/images/star1.png'),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      place.rating.toString(),
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${place.description}',
                                                ),

                                                SizedBox(
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
                                                      child: Row(
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
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                // Text('Latitude: ${place.latitude}'),
                                                // Text('Longitude: ${place.longitude}'),
                                                Divider(),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                Text(
                                  'Budget Estimate:',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Accommodation Range per Night",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  '${trip!.budgetEstimate!.accommodation!.rangePerNight}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Meals Range per Person",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  '${trip!.budgetEstimate!.mealsPerDayPerPerson!.range}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Text("Transportation Range",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.transportation!.rangeFor5Days}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Attractions Range",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.attractions!.rangeFor5DaysPerPerson}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Miscellaneous Range",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.miscellaneous!.rangeFor5Days}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Total Estimated Budget",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  ' ${trip!.budgetEstimate!.totalEstimatedBudgetPerPerson!.range}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
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
