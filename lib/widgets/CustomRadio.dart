import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String text;
  final int index;
  final int selectedTrip;
  final ValueChanged<int> onTap;

  CustomRadio({
    required this.text,
    required this.index,
    required this.selectedTrip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: (selectedTrip == index)
                ? Theme.of(context).primaryColorDark
                : Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 2,
                color: (selectedTrip == index)
                    ? Theme.of(context).primaryColor
                    : Colors.grey)),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: (selectedTrip != index)
                  ? Colors.grey
                  : Theme.of(context).primaryColor),
        ),
      ),
    );

    // OutlinedButton(
    //   style: OutlinedButton.styleFrom(
    //     backgroundColor: (selectedTrip == index)
    //         ? Theme.of(context).primaryColor
    //         : Colors.white,
    //   ),
    //   onPressed: () {
    //     onTap(index);
    //   },
    //   child: Text(
    //     text,
    //     style: TextStyle(
    //       color: (selectedTrip == index) ? Colors.white : Colors.black,
    //     ),
    //   ),
    // );
  }
}
