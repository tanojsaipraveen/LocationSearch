import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final RegExp _emailRegExp =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  bool _isEmailValid = true;

  sendPasswordResetMail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter you email and we will send you a password reset link",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
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
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
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
                        color: Colors.grey, // Adjust the color of the hint text
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
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 15),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: () {
                        sendPasswordResetMail();
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) => const MyHomePage()),
                        //     (Route<dynamic> route) => false);
                      },
                      child: const Text("RESET PASSWORD")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
