import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Event {
  final String eventType;
  final String subjectName;
  final String eventTime;

  Event({required this.eventType, required this.subjectName, required this.eventTime});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventType: json['event_type'] ?? '',
      subjectName: json['subject_name'] ?? '',
      eventTime: json['event_time'] ?? '',
    );
  }
}

class CalendarCard extends StatefulWidget {
  const CalendarCard({Key? key}) : super(key: key);

  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime? _selectedDate;
  List<Event> _events = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarDatePicker(
            firstDate: DateTime(2020, 12, 1),
            lastDate: DateTime(2029, 12, 1),
            initialDate: DateTime.now(),
            onDateChanged: (value) {
              setState(() {
                _selectedDate = value;
              });
              _fetchEvents(value);
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      _events[index].subjectName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${_events[index].eventType} at ${_events[index].eventTime}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Handle onTap event if needed
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchEvents(DateTime date) async {
    try {
      String sdate = date.toString(); 
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(sdate);
      String extractedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      final response = await http.get(Uri.parse('https://link-to-backend.azurewebsites.net/events?date=${extractedDate}'));
      if (response.statusCode == 200) {
        List<dynamic> eventData = jsonDecode(response.body);
        setState(() {
          _events = eventData.map((eventJson) => Event.fromJson(eventJson)).toList();
        });
      } else {
        print('Failed to fetch events. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}

 