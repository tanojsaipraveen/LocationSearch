import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String header;
  final int initialValue;
  final IconData iconData;
  final ValueChanged<int>? onValueChanged;
  // Callback function to emit value

  Counter({
    required this.header,
    required this.initialValue,
    required this.iconData,
    this.onValueChanged,
  });

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _value++;
    });
    if (widget.onValueChanged != null) {
      widget.onValueChanged!(_value); // Emit value on increment
    }
  }

  void _decrement() {
    setState(() {
      if (_value > 0) {
        _value--;
      }
    });
    if (widget.onValueChanged != null) {
      widget.onValueChanged!(_value); // Emit value on decrement
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(widget.iconData),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.header,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _decrement,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: _value != 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(_value.toString(),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: _increment,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
