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
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: (selectedTrip == index)
            ? Theme.of(context).primaryColor
            : Colors.white,
      ),
      onPressed: () {
        onTap(index);
      },
      child: Text(
        text,
        style: TextStyle(
          color: (selectedTrip == index) ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
