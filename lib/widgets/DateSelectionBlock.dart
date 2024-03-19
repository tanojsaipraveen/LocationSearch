import 'package:flutter/material.dart';

import '../Helpers/HelperMethods.dart';

class DateSelectionBlock extends StatelessWidget {
  final String title;
  final DateTime date;
  final Function(DateTime)? onTap;

  const DateSelectionBlock({
    required this.title,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(date),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 120,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.blueGrey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 0.8),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${date.day}',
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  HelperMethods.getMonthName(date.month),
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "'${(date.year) % 100}",
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            Text(
              HelperMethods.getDayName(date.weekday),
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.8),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
