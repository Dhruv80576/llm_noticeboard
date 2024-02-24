import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:llm_noticeboard/components/GroupCard.dart';
import 'package:llm_noticeboard/pages/ChatPage.dart';
import 'package:llm_noticeboard/pages/HomePage.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: GroupCard(),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 2,
          );
        },
        itemCount: 4,
      )),
    );
  }
}
