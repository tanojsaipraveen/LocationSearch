import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locationsearch/Screens/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final RegExp _emailRegExp =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*])(?=.{8,})');

  bool _isPasswordValid = true;

  bool _isEmailValid = true;
  bool _passwordsMatch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    "Register",
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Enter your details to Register.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(
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
                              BorderSide(color: Colors.black) // No border
                          ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust border radius here
                          borderSide: BorderSide(color: Colors.black)),
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
                  SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: repasswordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _passwordsMatch = passwordController.text == value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Re-enter your password',
                      errorText:
                          _passwordsMatch ? null : 'Passwords do not match',
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
                      hintText: 'ReEnter Password',
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
                                horizontal: 0, vertical: 15),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: Text("SIGN UP")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do you have account?"),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text(
                          "Signin Here",
                          style: TextStyle(color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
