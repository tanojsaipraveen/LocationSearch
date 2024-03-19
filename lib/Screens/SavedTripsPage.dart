import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SavedTripsPage extends StatefulWidget {
  const SavedTripsPage({Key? key}) : super(key: key);

  @override
  _SavedTripsPageState createState() => _SavedTripsPageState();
}

class _SavedTripsPageState extends State<SavedTripsPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Saved Trips",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
      ),
      body: SafeArea(
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
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
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
                  String location = document['Location'];
                  String activities = document['Activities']
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '');
                  String men = document['Men'].toString();
                  String women = document['Women'].toString();
                  String children = document['Children'].toString();
                  String triptype = document['TripType'].toString();
                  DateTime datefrom = document['DateFrom'].toDate();
                  String formattedatefrom =
                      DateFormat('yyyy-MM-dd').format(datefrom);
                  DateTime dateto = document['DateTo'].toDate();
                  String formattedateto =
                      DateFormat('yyyy-MM-dd').format(dateto);
                  return Dismissible(
                    key: Key(document.id),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text(
                                "Are you sure you want to delete this trip?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("DELETE"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("CANCEL"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      document.reference.delete();
                    },
                    background: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Chip(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Theme.of(context).primaryColor),
                                  label: Text(
                                    triptype,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                activities,
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('M : $men'),
                                Text('W : $women'),
                                Text('W : $children'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  formattedatefrom,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Icon(Icons.arrow_forward),
                                Text(
                                  formattedateto,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
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
    );
  }
}
