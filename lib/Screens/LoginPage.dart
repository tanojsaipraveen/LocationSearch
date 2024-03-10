import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Enter your Email address to sign in.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide:
                              BorderSide(color: Colors.black) // No border
                          ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          color:
                              Colors.grey, // Adjust the color of the hint text
                          fontWeight: FontWeight
                              .w400 // You can adjust other properties like fontSize, fontWeight, etc.
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide:
                              BorderSide(color: Colors.black) // No border
                          ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          color:
                              Colors.grey, // Adjust the color of the hint text
                          fontWeight: FontWeight
                              .w400 // You can adjust other properties like fontSize, fontWeight, etc.
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: Text("SIGN IN")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Create new account",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        icon: Icon(Icons.facebook),
                        label: Text(
                          'CONNECT WITH FACEBOOK',
                          style: TextStyle(wordSpacing: 2),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        icon: Icon(Icons.facebook),
                        label: Text(
                          'CONNECT WITH GOOGLE',
                          style: TextStyle(wordSpacing: 2),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
