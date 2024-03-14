import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:locationsearch/Screens/LoginPage.dart';
import 'package:locationsearch/Screens/Wrapper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('api_cache');
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyBxDqdOj1yxWd60zK3bJzOVkzsaEO6Eb_k",
            appId: "1:822565429375:android:8fe67966f394a2b22c5f4a",
            messagingSenderId: "822565429375",
            projectId: "ekart-b0cfe",
          ),
        )
      : await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: false,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Theme.of(context).primaryColor),
        // textTheme: TextTheme(bodyMedium: GoogleFonts.inter())
      ),
      home: Wrapper(),
    );
  }
}
