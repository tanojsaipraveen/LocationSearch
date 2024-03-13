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
    required Icon icon,
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
                  const Icon(Icons.person),
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
