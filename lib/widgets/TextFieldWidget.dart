import 'package:flutter/material.dart';
import 'package:locationsearch/DB/LocalRepo.dart';
import 'package:locationsearch/Screens/SearchPage.dart';
import 'package:page_transition/page_transition.dart';

class CustomTextField extends StatefulWidget {
  final Function(List<dynamic>) onDataReceived;

  const CustomTextField({Key? key, required this.onDataReceived})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController _controller = TextEditingController();
  late List<dynamic> returndata;
  bool isDataAviable = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        readOnly: true,
        onTap: () async {
          final dynamic data = await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const SearchPage(),
            ),
          );
          if (data != null) {
            _controller.text = data[0];
            returndata = data;
            setState(() {
              isDataAviable = true;
            });
            LocalRepo.insertRecentSearch(data);
            widget.onDataReceived(data);
          }
        },
        controller: _controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            height: 10,
            child: Image.asset('assets/images/googlemapsmax.png'),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: _controller.text.isNotEmpty,
                child: IconButton(
                  onPressed: () {
                    _controller.text = "";

                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Visibility(
                visible: _controller.text.isEmpty,
                child: IconButton(
                  onPressed: () {
                    _controller.text = "";
                    setState(() {});
                  },
                  icon: const Icon(Icons.mic),
                ),
              ),
              // Visibility(
              //   visible: _controller.text.isEmpty,
              //   child: const Padding(
              //     padding: EdgeInsets.only(right: 10, left: 5),
              //     child: CircleAvatar(
              //       radius: 16,
              //       backgroundImage: AssetImage(
              //         'assets/images/profile.jpg',
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust border radius here
            borderSide: BorderSide.none, // No border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust border radius here
            borderSide: BorderSide.none, // No border
          ),
          hintText: 'Enter Your Destination',
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.grey, // Adjust the color of the hint text
            fontWeight: FontWeight
                .w400, // You can adjust other properties like fontSize, fontWeight, etc.
          ),
        ),
      ),
    );
  }
}

// You might need to define SearchPage and LocalRepo classes
