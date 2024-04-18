import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:locationsearch/Screens/Wrapper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('api_cache');
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: dotenv.env["FirebaseAppKey"].toString(),
            appId: dotenv.env["FirebaseAppId"].toString(),
            messagingSenderId: dotenv.env["FirebaseMessageSenderId"].toString(),
            projectId: dotenv.env["FirebaseProjectId"].toString(),
          ),
        )
      : await Firebase.initializeApp();
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change this to the desired color
      statusBarIconBrightness:
          Brightness.dark, // Set status bar icon colors to white
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal,
        primaryColorDark: Colors.teal[100],
        textTheme: GoogleFonts.openSansTextTheme(),
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
