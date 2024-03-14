import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedTripdPage extends StatefulWidget {
  const SavedTripdPage({super.key});

  @override
  State<SavedTripdPage> createState() => _SavedTripdPageState();
}

class _SavedTripdPageState extends State<SavedTripdPage> {
  final user = FirebaseAuth.instance.currentUser;
  getTripData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('UserData')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              element.reference.get().then((value) => print(value['Men']));
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getTripData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(user!.uid)
              .collection('UserData')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(documents[index]['Men']
                      .toString()), // Access the fields of each document
                  // You can add more widgets here to display additional document data
                );
              },
            );
          },
        ));
  }
}
