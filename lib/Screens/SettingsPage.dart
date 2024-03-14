import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locationsearch/Screens/LoginPage.dart';
import 'package:locationsearch/Screens/SavedTripsPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            )),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('General'),
            tiles: [
              SettingsTile.navigation(
                title: Text('Saved Trips'),
                leading: Icon(Icons.save),
                description: Text('You can see saved trips'),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SavedTripdPage()));
                },
              )
            ],
          ),
          SettingsSection(
            title: Text('Profile'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onPressed: (context) {
                  signout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                  // Navigation.navigateTo(
                  //   context: context,
                  //   screen: AndroidSettingsScreen(),
                  //   style: NavigationRouteStyle.material,
                  // );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
