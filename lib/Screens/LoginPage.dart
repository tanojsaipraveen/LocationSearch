// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:locationsearch/Apis/GetLocationWeather.dart';
// import 'package:locationsearch/Screens/ForgotPasswordPage.dart';
// import 'package:locationsearch/Screens/HomePage.dart';
// import 'package:locationsearch/Screens/RegisterPage.dart';
// import 'package:toastification/toastification.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final RegExp _emailRegExp =
//       RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

//   bool _isEmailValid = true;

//   final RegExp _passwordRegExp =
//       RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*])(?=.{8,})');

//   bool _isPasswordValid = true;

//   login() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const MyHomePage()),
//           (Route<dynamic> route) => false);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         toastification.show(
//           context: context,
//           alignment: Alignment.center,
//           type: ToastificationType.info,
//           title: const Text('No user found for that email.'),
//           autoCloseDuration: const Duration(seconds: 5),
//         );
//       } else if (e.code == 'wrong-password') {
//         toastification.show(
//           context: context,
//           alignment: Alignment.center,
//           type: ToastificationType.info,
//           title: const Text('wrong-password'),
//           autoCloseDuration: const Duration(seconds: 5),
//         );
//       }
//     }
//   }

//   emaillogin() async {
//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const MyHomePage()),
//           (Route<dynamic> route) => false);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         toastification.show(
//           context: context,
//           alignment: Alignment.center,
//           type: ToastificationType.info,
//           title: const Text('No user found for that email.'),
//           autoCloseDuration: const Duration(seconds: 5),
//         );
//       } else if (e.code == 'wrong-password') {
//         toastification.show(
//           context: context,
//           alignment: Alignment.center,
//           type: ToastificationType.error,
//           title: const Text('Wrong password provided for that user.'),
//           autoCloseDuration: const Duration(seconds: 5),
//         );
//       } else {
//         toastification.show(
//           context: context,
//           alignment: Alignment.center,
//           type: ToastificationType.error,
//           title: Text(e.message.toString()),
//           autoCloseDuration: const Duration(seconds: 5),
//         );
//       }
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Welcome",
//                     style: TextStyle(fontSize: 50),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Enter your Email address to sign in.",
//                     style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                   ),
//                   const SizedBox(
//                     height: 80,
//                   ),
//                   TextField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'[a-zA-Z0-9@._-]')),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         _isEmailValid = _emailRegExp.hasMatch(value);
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Enter your email',
//                       labelStyle:
//                           TextStyle(color: Theme.of(context).primaryColor),
//                       errorText:
//                           _isEmailValid ? null : 'Please enter a valid email',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               10.0), // Adjust border radius here
//                           borderSide:
//                               const BorderSide(color: Colors.black) // No border
//                           ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               10.0), // Adjust border radius here
//                           borderSide: const BorderSide(color: Colors.black)),
//                       hintText: 'Email',
//                       hintStyle: const TextStyle(
//                           fontSize: 15,
//                           color:
//                               Colors.grey, // Adjust the color of the hint text
//                           fontWeight: FontWeight
//                               .w400 // You can adjust other properties like fontSize, fontWeight, etc.
//                           ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     onChanged: (value) {
//                       setState(() {
//                         _isPasswordValid = _passwordRegExp.hasMatch(value);
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Enter your password',
//                       labelStyle:
//                           TextStyle(color: Theme.of(context).primaryColor),
//                       errorText: _isPasswordValid
//                           ? null
//                           : 'Password requires at least one uppercase,lowercase letter,number and symbol.',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               10.0), // Adjust border radius here
//                           borderSide:
//                               const BorderSide(color: Colors.black) // No border
//                           ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                               10.0), // Adjust border radius here
//                           borderSide: const BorderSide(color: Colors.black)),
//                       hintText: 'Password',
//                       hintStyle: const TextStyle(
//                           fontSize: 15,
//                           color:
//                               Colors.grey, // Adjust the color of the hint text
//                           fontWeight: FontWeight
//                               .w400 // You can adjust other properties like fontSize, fontWeight, etc.
//                           ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ForgotPasswordPage()));
//                       },
//                       child: Text(
//                         "Forgot Password?",
//                         style: TextStyle(color: Theme.of(context).primaryColor),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Theme.of(context).primaryColor,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 0, vertical: 15),
//                             tapTargetSize: MaterialTapTargetSize.shrinkWrap),
//                         onPressed: () {
//                           if (emailController.text.isNotEmpty &&
//                               passwordController.text.isNotEmpty) {
//                             if (_isEmailValid) {
//                               emaillogin();
//                             } else {
//                               print('Invalid Email');
//                             }
//                           } else {
//                             print("Please enter details");
//                           }
//                         },
//                         child: const Text("SIGN IN")),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have account?"),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => const RegisterPage()));
//                         },
//                         child: Text(
//                           "Create new account",
//                           style:
//                               TextStyle(color: Theme.of(context).primaryColor),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Or",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     height: 45,
//                     width: double.infinity,
//                     child: SignInButton(
//                       Buttons.GoogleDark,
//                       text: "Sign up with Google",
//                       onPressed: () {
//                         login();
//                       },
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locationsearch/Screens/ForgotPasswordPage.dart';
import 'package:locationsearch/Screens/HomePage.dart';
import 'package:locationsearch/Screens/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 50),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Enter your Email address to sign in.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 80),
                    _buildEmailField(),
                    const SizedBox(height: 10),
                    _buildPasswordField(),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                        },
                        child: Text(
                          "Forgot Password?",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSignInButton(),
                    const SizedBox(height: 20),
                    _buildSignUpRow(),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    _buildGoogleSignInButton(),
                    const SizedBox(height: 20),
                    _buildMicrosoftSignInButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Enter your email',
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Enter your password',
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _signInWithEmail();
          }
        },
        child: const Text("SIGN IN"),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          child: Text(
            "Create new account",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: SignInButton(
        Buttons.GoogleDark,
        text: "Sign up with Google",
        onPressed: _signInWithGoogle,
      ),
    );
  }

  Widget _buildMicrosoftSignInButton() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: SignInButton(
        Buttons.Microsoft,
        text: "Sign up with Microsoft",
        onPressed: _signInWithMicrosoft,
      ),
    );
  }

  void _signInWithEmail() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 5),
      ));
    }
  }

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 5),
      ));
    }
  }

  void _signInWithMicrosoft() async {
    try {
      final provider = OAuthProvider("microsoft.com");
      provider.setCustomParameters({"tenant": dotenv.env["Tenant"].toString()});
      await FirebaseAuth.instance.signInWithProvider(provider);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 5),
      ));
    }
  }
}
