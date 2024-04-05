import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locationsearch/Screens/LoginPage.dart';
import 'package:locationsearch/Screens/SavedTripsPage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ValueNotifier<String> _version = ValueNotifier<String>("");
  signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().disconnect();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _version.value = info.version;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back,
      //         color: Colors.black,
      //         size: 28,
      //       )),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: IconButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       icon: const Icon(
            //         Icons.arrow_back,
            //         color: Colors.black,
            //         size: 28,
            //       )),
            // ),
            Expanded(
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: const Text('General'),
                    tiles: [
                      SettingsTile.navigation(
                        title: const Text('Saved Trips'),
                        leading: const Icon(Icons.save),
                        description: const Text('You can see saved trips'),
                        onPressed: (context) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SavedTripsPage()));
                        },
                      ),
                      SettingsTile.navigation(
                        title: Text("Version"),
                        description: ValueListenableBuilder<String>(
                          valueListenable: _version,
                          builder: (context, value, child) {
                            return Text(
                              value,
                            );
                          },
                        ),
                        leading: const Icon(Icons.info),
                      )
                    ],
                  ),
                  SettingsSection(
                    title: const Text('Profile'),
                    tiles: [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onPressed: (context) {
                          signout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
