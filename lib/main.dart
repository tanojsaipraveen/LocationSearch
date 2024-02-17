import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:locationsearch/Models/LocationDataModel.dart' as locationdata;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<locationdata.LocationDataModel> items = [];

  TextEditingController _controller = TextEditingController();
  Timer? _timer;

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
    Response response = await Dio().get('https://photon.komoot.io/api/',
        queryParameters: {'q': address, "limit": 5});
    final json = response.data;
    return (json['features'] as List)
        .map((e) => locationdata.LocationDataModel.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const Text(
            "Travel Advisor",
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _controller,
                onChanged: (val) {
                  if (val != '') {
                    _timer?.cancel();
                    // Start a new timer
                    _timer = Timer(Duration(milliseconds: 200), () {
                      placeAutoComplete(val);
                    });
                  } else {
                    items.clear();
                    setState(() {});
                  }
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                    prefixIcon: Icon(Icons.place),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your Destination',
                    prefixIconColor: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ...items
                .map((e) => ListTile(
                      leading: const Icon(Icons.place),
                      title: Text(e.properties!.name!),
                      onTap: () {
                        print(e.properties!.name);
                        _controller.text = e.properties!.name.toString();
                        items.clear();
                        setState(() {});
                      },
                    ))
                .toList()
          ],
        ));
  }
}
