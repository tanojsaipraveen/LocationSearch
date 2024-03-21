import 'package:flutter/material.dart';

class TravelActivitySelector extends StatefulWidget {
  final List<String> travelActivities;
  final Function(List<String>) onSelectionChanged;

  TravelActivitySelector({
    required this.travelActivities,
    required this.onSelectionChanged,
  });

  @override
  _TravelActivitySelectorState createState() => _TravelActivitySelectorState();
}

class _TravelActivitySelectorState extends State<TravelActivitySelector> {
  List<String> selectedActivities = [];

  void _handleActivitySelected(String activity) {
    setState(() {
      if (selectedActivities.contains(activity)) {
        selectedActivities.remove(activity);
      } else {
        selectedActivities.add(activity);
      }
      widget.onSelectionChanged(selectedActivities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Wrap(
        //   alignment: WrapAlignment.start,
        //   spacing: 8.0,
        //   runSpacing: 0.0,
        //   children: List<Widget>.generate(
        //     widget.travelActivities.length,
        //     (int index) {
        //       return Container(
        //         width: 80,
        //         height: 100,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.white,
        //         ),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Icon(Icons.person),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(widget.travelActivities[index]),
        //           ],
        //         ),
        //       );

        // ChoiceChip(
        //   label: Text(
        //     widget.travelActivities[index],
        //     style: TextStyle(
        //       color: selectedActivities
        //               .contains(widget.travelActivities[index])
        //           ? Colors.white // Set text color to white for selected chips
        //           : Colors
        //               .black, // Set text color to black for unselected chips
        //     ),
        //   ),
        //   selected:
        //       selectedActivities.contains(widget.travelActivities[index]),
        //   selectedColor: Theme.of(context)
        //       .primaryColor, // Customize the selected chip color
        //   onSelected: (bool selected) {
        //     _handleActivitySelected(widget.travelActivities[index]);
        //   },
        // );
        //     },
        //   ).toList(),
        // );

        Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 0.0,
      children: List<Widget>.generate(
        widget.travelActivities.length,
        (int index) {
          return ChoiceChip(
            label: Text(
              widget.travelActivities[index],
              style: TextStyle(
                color: selectedActivities
                        .contains(widget.travelActivities[index])
                    ? Colors.white // Set text color to white for selected chips
                    : Colors
                        .black, // Set text color to black for unselected chips
              ),
            ),
            selected:
                selectedActivities.contains(widget.travelActivities[index]),
            selectedColor: Theme.of(context)
                .primaryColor, // Customize the selected chip color
            onSelected: (bool selected) {
              _handleActivitySelected(widget.travelActivities[index]);
            },
          );
        },
      ).toList(),
    );
  }
}
