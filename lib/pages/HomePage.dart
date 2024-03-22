import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:llm_noticeboard/pages/Calendar.dart';
import 'package:llm_noticeboard/pages/Dashboard.dart';
import 'package:llm_noticeboard/pages/Groups.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> pages = [
    DashboardPage(
      key: PageStorageKey('Dashboard'),
    ),
    GroupsPage(
      key: PageStorageKey('Groups'),
    ),
    CalendarPage(
      key: PageStorageKey('Calendar'),
    )
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  var select_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Link To"),
      ),
      body: PageStorage(bucket: bucket, child: pages[select_index]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            select_index = value;
          });
        },
        currentIndex: select_index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar")
        ],
      ),
    );
  }
}
