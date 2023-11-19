import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../helper/constants/format_calendart.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key, required this.selectedDay});
  DateTime selectedDay;
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome To Code Daily'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(
              dateFormat.format(widget.selectedDay),
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
            TableCalendar(
              rowHeight: 43,
              focusedDay: today,
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              locale: 'en_US',
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, widget.selectedDay),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  widget.selectedDay = selectedDay;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, widget.selectedDay);
              },
              child: const Text('Oke'),
            ),
          ],
        ),
      ),
    );
  }
}
