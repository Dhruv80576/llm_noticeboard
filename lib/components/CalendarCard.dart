import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CalendarDatePicker(
        firstDate: DateTime(2020, 12, 1),
        lastDate: DateTime(2029, 12, 1),
        initialDate: DateTime.now(),
        onDateChanged: (value) {},
      ),
    );
  }
}
