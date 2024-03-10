import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String header;
  final int initialValue;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  Counter({
    required this.header,
    required this.initialValue,
    this.onIncrement,
    this.onDecrement,
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
    if (widget.onIncrement != null) {
      widget.onIncrement!();
    }
  }

  void _decrement() {
    setState(() {
      if (_value < 1) {
        _value = 0;
      } else {
        _value--;
      }
    });
    if (widget.onDecrement != null) {
      widget.onDecrement!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(widget.header),
        ),
        Row(
          children: [
            Container(
              child: GestureDetector(
                onTap: _decrement,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                _value.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: _increment,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
