import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:locationsearch/Screens/HomePage.dart';
import 'package:locationsearch/Screens/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp _emailRegExp =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  bool _isEmailValid = true;

  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*])(?=.{8,})');

  bool _isPasswordValid = true;
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
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Enter your Email address to sign in.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._-]')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid = _emailRegExp.hasMatch(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      errorText:
                          _isEmailValid ? null : 'Please enter a valid email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide:
                              const BorderSide(color: Colors.black) // No border
                          ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide: const BorderSide(color: Colors.black)),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          color:
                              Colors.grey, // Adjust the color of the hint text
                          fontWeight: FontWeight
                              .w400 // You can adjust other properties like fontSize, fontWeight, etc.
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = _passwordRegExp.hasMatch(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      errorText: _isPasswordValid
                          ? null
                          : 'Password requires at least one uppercase,lowercase letter,number and symbol.',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide:
                              const BorderSide(color: Colors.black) // No border
                          ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide: const BorderSide(color: Colors.black)),
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

                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                              (Route<dynamic> route) => false);
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            if (_isEmailValid) {
                              // Email is valid, perform your logic here
                              print('Valid Email: ${emailController.text}');
                              print("Success login");
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => const MyHomePage()),
                              //     (Route<dynamic> route) => false);
                            } else {
                              // Email is not valid, show an error message
                              print('Invalid Email');
                            }
                          } else {
                            print("Please enter details");
                          }
                        },
                        child: const Text("SIGN IN")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?"),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                              (Route<dynamic> route) => false);
                        },
                        child: const Text(
                          "Create new account",
                          style: TextStyle(color: Colors.green),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: SignInButton(
                      Buttons.GoogleDark,
                      text: "Sign up with Google",
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: SignInButton(
                      Buttons.Facebook,
                      text: "Sign up with Facebook",
                      onPressed: () {},
                    ),
                  ),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton.icon(
                  //       style: ElevatedButton.styleFrom(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 0, vertical: 10),
                  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  //       onPressed: () {},
                  //       icon: Icon(Icons.facebook),
                  //       label: Text(
                  //         'CONNECT WITH GOOGLE',
                  //         style: TextStyle(wordSpacing: 2),
                  //       )),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
